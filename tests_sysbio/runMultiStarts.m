function parameters = runMultiStarts(objectiveFunction, maxFunEvals, nStarts, solver, nPar, parMin, parMax, useGradients)

if strcmp(solver,'hybrid-snobfit')
    parameters = runMultiStartsHybrid(objectiveFunction, maxFunEvals, nStarts, solver, nPar, parMin, parMax, useGradients);
    return;
end

%     clearPersistentVariables();

%     tol = 1e-10;
numevals = maxFunEvals*nPar;

options.obj_type = 'log-posterior';
options.comp_type = 'sequential';
options.proposal = 'latin hypercube';
options.n_starts = nStarts;
if useGradients
    options.objOutNumber = 2;
else
    options.objOutNumber = 1;
end

options.mode = 'text';
options.localOptimizer = solver;

% set maxFunEvals for the different optimizers
switch solver
    case 'fmincon'
        lOptions = optimoptions(@fmincon);
        lOptions.MaxFunctionEvaluations = numevals;
        lOptions.MaxIterations = numevals;
        lOptions.Display = 'iter';
        if useGradients
            options.objOutNumber = 2;
            lOptions.GradObj = 'on';
        else
            lOptions.GradObj = 'off';
        end
    case 'dhc'
        lOptions.MaxFunEvals = numevals;
    case 'rcs'
        lOptions.MaxFunEvals = numevals;
        lOptions.MaxIter = numevals;
    case 'bobyqa'
        lOptions.MaxFunEvals = numevals;
        lOptions.Rhobeg = 0.1*max(abs(parMax-parMin));
    case 'mcs'
        lOptions.printLevel = 1;
        lOptions.MaxFunEvals = numevals;
    case 'direct'
        lOptions.maxevals = numevals;
        lOptions.maxits = numevals;
    case 'meigo-ess'
        lOptions.inter_save = false;
        lOptions.maxeval = numevals;
        lOptions.maxtime = Inf;
        lOptions.local.solver = 'fmincon';
        lOptions.local.finish = 'fmincon';
        lOptions.local.solver_options = optimset;
        if useGradients
            lOptions.local.solver_options.GradObj = 'on';
            lOptions.local.finish_options.GradObj = 'on';
        else
            lOptions.local.solver_options.GradObj = 'off';
            lOptions.local.finish_options.GradObj = 'off';
        end
    case 'cmaes'
        lOptions.MaxFunEvals = numevals;
        lOptions.MaxIter = numevals;
        lOptions.LBounds = parMin;
        lOptions.UBounds = parMax;
    case 'pswarm'
        lOptions.MaxIter = numevals;
        lOptions.MaxObj  = numevals;
        
    otherwise
        error('solver not recognized');
end
options.localOptimizerOptions = lOptions;

parameters.number = nPar;
parameters.min = parMin;
parameters.max = parMax;

parameters = getMultiStarts(parameters, objectiveFunction, options);

% do not want to store this
for j = 1:nStarts
    parameters.MS.hessian = [];
end

end % function

function parameters = runMultiStartsHybrid(objectiveFunction, maxFunEvals, nStarts, solver, nPar, parMin, parMax, useGradients)

numevals = maxFunEvals*nPar;

parameters = struct();
parameters.min = parMin;
parameters.max = parMax;
parameters.number = nPar;

optionsSS = PestoOptions();
optionsSS.obj_type = 'log-posterior';
optionsSS.n_starts = nStarts;
optionsSS.ss_optimizer = 'snobfit';
optionsSS.ss_maxFunEvals = 50*nStarts;

guess = getStartpointSuggestions(parameters, objectiveFunction, optionsSS);

options = PestoOptions();
options.obj_type = 'log-posterior';
options.n_starts = nStarts;
options.proposal = 'user-supplied';
options.objOutNumber = 2;
options.mode = 'text';

options.localOptimizer = 'fmincon';
lOptions = optimoptions(@fmincon);
lOptions.MaxFunctionEvaluations = numevals;
lOptions.MaxIterations = numevals;
lOptions.Display = 'iter';
lOptions.GradObj = 'on';
options.localOptimizerOptions = lOptions;

parameters.guess = guess;

parameters = getMultiStarts(parameters, objectiveFunction, options);

end