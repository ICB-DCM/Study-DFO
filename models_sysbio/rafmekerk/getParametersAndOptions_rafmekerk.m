function [parameters,options] = getParametersAndOptions_rafmekerk(approach)

nStarts = 20;

options.MS = PestoOptions();
options.MS.n_starts = nStarts; % actually 500
options.MS.mode = 'text';
options.MS.localOptimizer = 'fmincon';
options.MS.localOptimizerOptions = optimset('algorithm','interior-point',...
    'display','iter',...
    'GradObj','on',...
    'MaxIter',5000,...
    'TolFun',1e-10,...
    'TolX',1e-10,...
    'MaxFunEvals',40000,...
    'PrecondBandWidth', inf);
options.MS.obj_type = 'negative log-posterior';

nPar = 28; % maximum number of parameters
minPar = -7*ones(nPar,1);
maxPar = 5*ones(nPar,1);

rng(0);
par0 = bsxfun(@plus,minPar,bsxfun(@times,maxPar - minPar, lhsdesign(nStarts,nPar,'smooth','off')'));

switch approach
    case 'standard'
        nPar = 28;
    case {'hierarchical','hierarchical-adjoint'}
        nPar = 12;
        
        sc.exp_groups.bc_idxs = {1:3};
        sc.exp_groups.noise_idxs = {1:3};
        
        sc.obs_groups.bc_idxs = {1,2};
        sc.obs_groups.b_mode = {'absolute','absolute'};
        sc.obs_groups.c_mode = {'multiple','multiple'};
        sc.obs_groups.noise_idxs = {1,2};
        sc.obs_groups.noise_mode = {'multiple','multiple'};
        
        sc.distribution = 'normal';
        
        options.sc = sc;
        
    case {'hierarchical-noreps','hierarchical-noreps-adjoint'}
        nPar = 12;
        
        sc.exp_groups.bc_idxs = {1:3};
        sc.exp_groups.noise_idxs = {1:3};
        
        sc.obs_groups.bc_idxs = {1,2,3,4,5,6,7,8};
        sc.obs_groups.b_mode = {'absolute','absolute','absolute','absolute','absolute','absolute','absolute','absolute'};
        sc.obs_groups.c_mode = {'multiple','multiple','multiple','multiple','multiple','multiple','multiple','multiple'};
        sc.obs_groups.noise_idxs = {1,2,3,4,5,6,7,8};
        sc.obs_groups.noise_mode = {'multiple','multiple','multiple','multiple','multiple','multiple','multiple','multiple'};
        
        sc.distribution = 'normal';
        
        options.sc = sc;
        
end

parameters.number = nPar;
parameters.min = minPar(1:nPar,1);
parameters.max = maxPar(1:nPar,1);
parameters.guess = par0(1:nPar,1:nStarts);

end
