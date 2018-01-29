function [x,fval,exitflag,output] = ysnobfit(fun,lb,ub,options)
file = 'snobfit_datafile';

u = lb(:);
v = ub(:);
n = size(u,1);

% meaningful default values according to snobtest.m
npoint = n+6; % number of random start points to be generated
nreq = n+6; % number of points to be generated in each call to snobfit
x = rand(npoint,n);
f = zeros(npoint,2);
x = x*diag(v-u) + ones(npoint,1)*u'; % generation of npoint random starting points in [u,v]
dx = (v-u)'*1e-5; % resolution vector
p = 0.5; % probability of generating a point of 'class 4'
params = struct('bounds',{u,v},'nreq',nreq,'p',p);

% compute function values
for j=1:npoint
    f(j,:) = [fun(x(j,:)), -1];
end
funEvals = npoint;
[fbest,jbest] = min(f);
xbest = x(jbest,:);

while funEvals < options.MaxFunEvals
    % repeat until maxFunEvals function evals, unless stopping
    % criterion reached before
    
    if funEvals == npoint % initial call
        [request,~,~] = snobfit(file,x,f,params,dx);
    else
        [request,~,~] = snobfit(file,x,f,params);
    end
    
    clear x
    clear f
    x = rand(nreq,n);
    f = zeros(nreq,2);
    for j=1:nreq % evaluate f at new proposed points
        x(j,:) = request(j,1:n);
        f(j,:) = [objfun(x(j,:)), -1];
    end
    funEvals = funEvals + nreq;
    [fbestnew,jbestnew] = min(f);
    if fbestnew < fbest
        fbest = fbestnew;
        xbest = x(jbestnew,:);
    end
    
    % check stopping criterion
    % TODO what would be a useful stopping criterion?
end

fval = fbest;
x = xbest;
exitflag = 0; % TODO
output.funcCount = funEvals;

end

