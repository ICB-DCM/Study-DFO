if ~exist('data_hopfbifurcation.mat','file')
    run preliminaries_hopfbifurcation.m
end

load data_hopfbifurcation.mat

parameters.number = length(p);
parameters.min = lb;
parameters.max = ub;

pestoOptions = PestoOptions();
pestoOptions.obj_type = 'log-posterior';
pestoOptions.comp_type = 'sequential';
pestoOptions.proposal = 'latin hypercube';
pestoOptions.n_starts = 10;
pestoOptions.localOptimizer = 'fmincon';
pestoOptions.objOutNumber = 2;
pestoOptions.mode = 'text';

lOptions = optimoptions(@fmincon);
lOptions.MaxFunctionEvaluations = 5000;
lOptions.MaxIterations = 5000;
lOptions.Display = 'iter';
lOptions.GradObj = 'on';
pestoOptions.localOptimizerOptions = lOptions;

objfun = @(x) llh(x, D, @simulate_hopfbifurcation);

parameters_res = getMultiStarts(parameters, objfun, pestoOptions);