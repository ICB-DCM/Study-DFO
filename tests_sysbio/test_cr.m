clear;
clear persistent;
close all;

% parameters_meigo = test('meigo-ess',10,1000);
% parameters_fmincon = test('fmincon',10,1000);
parameters_dhc = test('dhc',20,1000);
% parameters_rcs = test('rcs',10,1000);
% parameters_mcs = test('mcs',10,1000);
% parameters_pswarm = test('pswarm',10,1000);
% parameters_direct = test('direct',10,10000);

function [parameters_res] =  test(solver,nStarts,maxFunEvals)

addpath('../models_sysbio/conversion_reaction');

% Seed the random number generator. Seeding the random number generator
% ensures that everytime this example is run, the same sequence of random
% numbers is generated, and thus, the same starting points for multi-start
% optimization will be used. This is helpful for debugging or comparing
% results across different machines.
% Results might vary though if PestoOptions.comp_type is set to 'parallel'
rng(0);

%% Model Definition
% See logLikelihoodCR.m for a detailed description

%% Data
% We fix an artificial data set. It consists of a vector of time points t
% and a measurement vector y. This data was created using the parameter
% values which are assigned to theta_true and by adding normally distributed
% measurement noise with variance sigma2.

% True parameters
% theta_true = [-2.5;-2];

% Time points, measurement noise and measurement data
t = (0:10)';
sigma2 = 0.015^2;
y = [0.0244; 0.0842; 0.1208; 0.1724; 0.2315; 0.2634; ...
    0.2831; 0.3084; 0.3079; 0.3097; 0.3324];


%% Definition of the Parameter Estimation Problem
% In order to run any PESTO routine, at least the parameters struct with
% the fields shown here and the objective function need to be defined,
% since they are mandatory for getMultiStarts, which is usually the first
% routine needed for any parameter estimation problem

% parameters
nPar = 2;
lb = [-7;-7];
ub = [3;3];

% Log-likelihood function
objectiveFunction = @(theta) logLikelihoodCR(theta, t, y, sigma2, 'log');

%% Optimization
% A multi-start local optimization is performed within the bounds defined in
% parameters.min and .max in order to infer the unknown parameters from
% measurement data. Therefore, a PestoOptions object is created and
% some of its properties are set accordingly.

% Optimization
parameters_res = runMultiStarts(objectiveFunction, nStarts, maxFunEvals, solver, nPar, lb, ub,false);
printResultParameters(parameters_res);
save(['test_cr_' solver '_' num2str(nStarts) '_' num2str(maxFunEvals)],'parameters_res');

end % function

function parameters = runMultiStarts(objectiveFunction, nStarts, maxFunEvals, solver, nPar, parMin, parMax, useGradients)
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
        
    case 'dhc'
        
    case 'rcs'
        
    case 'mcs'
        
    case 'direct'
        
    case 'meigo-ess-fmincon'
        
    case 'pswarm'
        options.localOptimizerOptions.MaxIter = numevals;
        options.localOptimizerOptions.MaxObj  = numevals;
    
    otherwise 
        error('solver not recognized');
end
if ~strcmp(solver,'meigo-ess')
    options.localOptimizerOptions.MaxFunctionEvaluations = numevals;
    options.localOptimizerOptions.MaxFunEvals   = numevals;
    options.localOptimizerOptions.MaxIterations = numevals;
    options.localOptimizerOptions.MaxIter       = numevals;
    options.localOptimizerOptions.MaxObj        = numevals;
    options.localOptimizerOptions.OutputFcn = @outfun;
%     options.localOptimizerOptions.Display = 'debug';
%     options.localOptimizerOptions.GradObj='off';
    % options.localOptimizerOptions.Display = 'off';
else
    options.localOptimizerOptions.maxeval       = numevals;
    options.localOptimizerOptions.maxtime       = Inf;
    options.localOptimizerOptions.local.solver  = 'fmincon';
    options.localOptimizerOptions.local.finish  = 'fmincon';
    options.localOptimizerOptions.local.iterprint = 0;
    options.localOptimizerOptions.iterprint     = 0;
    options.localOptimizerOptions.plot          = 0;
end

% set tolerances for the different optimizers
%     options.localOptimizerOptions.TolX          = tol;
%     options.localOptimizerOptions.TolFun        = tol;
%     options.localOptimizerOptions.StepTolerance = tol;

% more options


parameters.number = nPar;
parameters.min = parMin;
parameters.max = parMax;

parameters = getMultiStarts(parameters, objectiveFunction, options);

% do not want to store this
for j = 1:nStarts
    parameters.MS.hessian = [];
end

end