function [xbst,fbst,exitflag,output] = ysnobfit(fun,lb,ub,options)
file = 'snobfit_datafile';

lb = lb(:);
ub = ub(:);
dim = size(lb,1);

% options
options = f_validateOptions(options,dim);
tolFun = options.TolFun;
maxStallGenerations = options.MaxStallGenerations;
maxGenerations = options.MaxGenerations; 
maxFunEvals = options.MaxFunEvals;
% number of points to be generated in each call to snobfit
popSize = options.PopulationSize; 

% create initial population
f = zeros(popSize,2);
% latin hypercube starting points, popSize * dim
if ~isempty(options.Guess) && size(options.Guess,2) == popSize
    x = options.Guess';
else
    x = bsxfun(@plus,lb,bsxfun(@times,ub-lb,lhsdesign(popSize,dim,'smooth','off')'))';
end
dx = (ub-lb)'*1e-5; % resolution vector
p = 0.5; % probability of generating a point of 'class 4'
params = struct('bounds',{lb,ub},'nreq',popSize,'p',p);

% compute function values
for j=1:popSize
    f(j,:) = [fun(x(j,:)), -1];
end
jFunEvals = popSize;
[fbest,jbest] = min(f(:,1));
xbest = x(jbest,:);

% generation counters
jGenerations = 0;
jStallGenerations = 0;

% main loop
while jGenerations < maxGenerations ...
        && jStallGenerations < maxStallGenerations ...
        && jFunEvals < maxFunEvals
    
    jGenerations = jGenerations + 1;
    
    if jFunEvals == popSize % initial call
        [request,~,~] = snobfit(file,x,f,params,dx);
    else
        [request,~,~] = snobfit(file,x,f,params);
    end
    
    for j=1:size(request,1) % evaluate f at new proposed points
        x(j,:) = request(j,1:dim);
        f(j,:) = [fun(x(j,:)), -1];
    end
    jFunEvals = jFunEvals + popSize;
    [fbestnew,jbestnew] = min(f(:,1));
    
    delta_f = fbestnew - fbest;
    
    % is sufficiently better estimate?
    if delta_f < tolFun
        jStallGenerations = 0;
    else
        jStallGenerations = jStallGenerations + 1;
    end
    
    % is better estimate?
    if fbestnew < fbest
        fbest = fbestnew;
        xbest = x(jbestnew,:);
    end
end

fbst = fbest;
xbst = xbest;
if jStallGenerations >= maxStallGenerations
    exitflag = 0;
else
    exitflag = 1;
end
output.funcCount = jFunEvals;
output.population = x';
output.fvals = f(:,1);

end

function [optionsSF] = f_validateOptions(options,dim)
   
optionsSF = struct();

if isfield(options,'MaxStallGenerations') && ~isempty(options.MaxStallGenerations)
    optionsSF.MaxStallGenerations = options.MaxStallGenerations;
else
    optionsSF.MaxStallGenerations = 50;
end

if isfield(options,'MaxGenerations') && ~isempty(options.MaxGenerations)
    optionsSF.MaxGenerations = options.MaxGenerations;
else
    optionsSF.MaxGenerations = 100*dim;
end

if isfield(options,'TolFun') && ~isempty(options.TolFun)
    optionsSF.TolFun = options.TolFun;
else
    optionsSF.TolFun = 1e-8;
end

if isfield(options,'MaxFunEvals') && ~isempty(options.MaxFunEvals)
    optionsSF.MaxFunEvals = options.MaxFunEvals;
else
    optionsSF.MaxFunEvals = Inf;
end

if isfield(options,'PopulationSize') && ~isempty(options.PopulationSize)
    optionsSF.PopulationSize = options.PopulationSize;
else
    optionsSF.PopulationSize = dim + 6;
end

if isfield(options,'Guess')
    optionsSF.Guess = options.Guess;
else
    optionsSF.Guess = [];
end

end

