clear;
clear persistent;
close all;

addpath('../models_sysbio/conversion_reaction');

maxFunEvals = 1000;
nStarts = 10;

parameters_fmincon = test('fmincon',maxFunEvals,nStarts);
parameters_dhc = test('dhc',maxFunEvals,nStarts);
parameters_rcs = test('rcs',maxFunEvals,nStarts);
% parameters_bobyqa = test('bobyqa',maxFunEvals,nStarts);
parameters_mcs = test('mcs',maxFunEvals,nStarts);
parameters_direct = test('direct',maxFunEvals,nStarts);
parameters_meigo = test('meigo-ess',maxFunEvals,nStarts);
parameters_cmaes = test('cmaes',maxFunEvals,nStarts);
parameters_pswarm = test('pswarm',maxFunEvals,nStarts);

function [parameters_res] =  test(solver,maxFunEvals,nStarts)

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
parameters_res = runMultiStarts(objectiveFunction, maxFunEvals, nStarts, solver, nPar, lb, ub, false);
printResultParameters(parameters_res);
save(['test_cr_' solver '_' num2str(nStarts) '_' num2str(maxFunEvals)],'parameters_res');

end % function

function parameters = runMultiStarts(objectiveFunction, maxFunEvals, nStarts, solver, nPar, parMin, parMax, useGradients)
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
        lOptions.MaxFunctionEvaluations = numevals;
        lOptions.MaxIterations = numevals;
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
        lOptions.Rhobeg = 0.1*max(abs(ub-lb));
    case 'mcs'
        lOptions.MaxFunEvals = numevals;
    case 'direct'
        lOptions.maxevals = numevals;
        lOptions.maxits = numevals;
    case 'meigo-ess'
        lOptions.inter_save = false;
        lOptions.maxeval = numevals;
        lOptions.maxtime = Inf;
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

end