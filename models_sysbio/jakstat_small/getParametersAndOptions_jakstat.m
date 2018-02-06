function [parameters,options] = getParametersAndOptions_jakstat(approach)

nStarts = 20;

options.MS = PestoOptions();
options.MS.n_starts = nStarts; % actually 500
options.MS.mode = 'text';
options.MS.localOptimizer = 'fmincon';
options.MS.localOptimizerOptions = optimset('algorithm','interior-point',...
    'display','iter',...
    'GradObj','on',...
    'MaxIter',2000,...
    'TolFun',1e-10,...
    'TolX',1e-10,...
    'MaxFunEvals',2000,...
    'PrecondBandWidth', inf);
options.MS.obj_type = 'negative log-posterior';

nPar = 17; % maximum number of parameters
minPar = -5*ones(nPar,1);
maxPar = 3*ones(nPar,1);
maxPar(4)  =  6;
maxPar(2)  =  6;
minPar(10) = -6;
minPar(4)  = -3;
minPar(2)  = -3;

rng(0);
par0 = bsxfun(@plus,minPar,bsxfun(@times,maxPar - minPar, lhsdesign(nStarts,nPar,'smooth','off')'));
   
switch approach
    case 'standard'
        nPar = 17;
        
    case 'hierarchical-adjoint'
        nPar = 12;
        
        sc.exp_groups.bc_idxs = {1};
        sc.exp_groups.noise_idxs = {1};
        
        sc.obs_groups.bc_idxs = {1,2,3};
        sc.obs_groups.b_mode = {'absolute','absolute','absolute'};
        sc.obs_groups.c_mode = {'multiple','multiple','absolute'};
        sc.obs_groups.noise_idxs = {1,2,3};
        sc.obs_groups.noise_mode = {'multiple','multiple','multiple'};
        
        sc.distribution = 'normal';
        
        options.sc = sc;
        
    case 'hierarchical'
        nPar = 12;
        
        sc.exp_groups.bc_idxs = {1};
        sc.exp_groups.noise_idxs = {1};
        
        sc.obs_groups.bc_idxs = {1,2,3};
        sc.obs_groups.b_mode = {'absolute','absolute','absolute'};
        sc.obs_groups.c_mode = {'multiple','multiple','absolute'};
        sc.obs_groups.noise_idxs = {1,2,3};
        sc.obs_groups.noise_mode = {'multiple','multiple','multiple'};
        
        sc.distribution = 'normal';
        
        options.sc = sc;
        
    case 'hierarchical-offsets'
        nPar = 10;

        sc.exp_groups.bc_idxs = {1};
        sc.exp_groups.noise_idxs = {1};
        
        sc.obs_groups.bc_idxs = {1,2,3};
        sc.obs_groups.b_mode = {'multiple','multiple','absolute'};
        sc.obs_groups.c_mode = {'multiple','multiple','absolute'};
        sc.obs_groups.noise_idxs = {1,2,3};
        sc.obs_groups.noise_mode = {'multiple','multiple','multiple'};
        
        sc.distribution = 'normal';
        
        options.sc = sc;
        
    case 'hierarchical-adjoint-offsets'
        nPar = 10;
        
        
        sc.exp_groups.bc_idxs = {1};
        sc.exp_groups.noise_idxs = {1};
        
        sc.obs_groups.bc_idxs = {1,2,3};
        sc.obs_groups.b_mode = {'multiple','multiple','absolute'};
        sc.obs_groups.c_mode = {'multiple','multiple','absolute'};
        sc.obs_groups.noise_idxs = {1,2,3};
        sc.obs_groups.noise_mode = {'multiple','multiple','multiple'};
        
        sc.distribution = 'normal';
        
        options.sc = sc;
        
end

parameters.number = nPar;
parameters.min = minPar(1:nPar,1);
parameters.max = maxPar(1:nPar,1);
parameters.guess = par0(1:nPar,1:nStarts);

end
