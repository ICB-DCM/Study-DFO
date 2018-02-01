clear;
clear persistent;
close all;

parameters_meigo = test('meigo-ess',10,1000);
parameters_fmincon = test('fmincon',10,1000);
parameters_dhc = test('dhc',10,1000);
parameters_rcs = test('rcs',10,1000);
parameters_mcs = test('mcs',10,1000);

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
parameters_res = runMultiStarts(objectiveFunction, nStarts, maxFunEvals, solver, nPar, lb, ub);
printResultParameters(parameters_res);
save(['test_cr_' solver '_' num2str(nStarts) '_' num2str(maxFunEvals)],'parameters_res');

end % function

function parameters = runMultiStarts(objectiveFunction, nStarts, maxFunEvals, solver, nPar, parMin, parMax, varargin)
%     clearPersistentVariables();

%     tol = 1e-10;
numevals = maxFunEvals*nPar;

if strcmp(solver,'fmincon'), options = PestoOptions(); end
options.obj_type = 'log-posterior';
options.comp_type = 'sequential';
options.proposal = 'latin hypercube';
options.n_starts = nStarts;
options.objOutNumber = 1;
options.mode = 'text';
options.localOptimizer = solver;

% set maxFunEvals for the different optimizers
if strcmp(solver,'fmincon') || strcmp(solver,'dhc') || strcmp(solver,'rcs')
    options.localOptimizerOptions.MaxFunctionEvaluations = numevals;
    options.localOptimizerOptions.MaxFunEvals   = numevals;
    options.localOptimizerOptions.MaxIterations = numevals;
    options.localOptimizerOptions.MaxIter       = numevals;
    options.localOptimizerOptions.GradObj='off';
    % options.localOptimizerOptions.Display = 'off';
elseif strcmp(solver,'meigo-ess')
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

%% Create Artificial Data for Parameter Estimation
% The necessary variables are set (Parameter bounds, variance, ...)
nTimepoints = 50;      % Time points of Measurement
nMeasure    = 1;        % Number of experiments
sigma2      = 0.05^2;   % Variance of Measurement noise
lowerBound  = -10;      % Lower bound for parameters
upperBound  = 5;        % Upper bound for parameters
theta       = [1.1770; -2.3714; -0.4827; -5.5387]; % True parameter values

% Creation of data
% Once the two files getMeasuredData.m and getInitialConcentrations.m are
% written, the two following lines can be commented
if (~exist('getMeasuredData.m', 'file') || ~exist('getInitialConcentrations.m','file'))
    disp(' Write new measurement data...');
    performNewMeasurement(theta, nMeasure, nTimepoints, sigma2);
end

% The measurement data is read out from the files where it is saved
yMeasured = getMeasuredData();
con0 = getInitialConcentrations();

%% Generation of the structs and options for PESTO
% The structs and the PestoOptions object, which are necessary for the 
% PESTO routines to work are created and set to convenient values

% objective function
objectiveFunction = @(theta) logLikelihoodEC(theta, yMeasured, sigma2, con0, nTimepoints, nMeasure);


%% Perform Multistart optimization
% A multi-start local optimization is performed within the bound defined in
% parameters.min and .max in order to infer the unknown parameters from 
% measurement data.

disp(['True parameters: ',mat2str(theta)]);

disp(' Optimizing parameters...');
n_starts = 10;
lb = lowerBound * ones(4,1);
ub = upperBound * ones(4,1);

disp('fmincon:');
parameters_fmincon = runMultiStarts(objectiveFunction, 1, n_starts, 'fmincon', 4, lb, ub);
printResultParameters(parameters_fmincon);

disp('rsc:');
parameters_rsc = runMultiStarts(objectiveFunction, 1, n_starts, 'rsc', 4, lb, ub);
printResultParameters(parameters_rsc);

% disp('hctt:');
% parameters_hctt = runMultiStarts(objectiveFunction, 1, n_starts, 'hctt', 4, lb, ub);
% printResultParameters(parameters_hctt);

disp('cs:');

% parameters_cs = runMultiStarts(objectiveFunction, 1, n_starts, 'cs', 4, lb, ub);
% printResultParameters(parameters_cs);

% disp('dhc:');
% parameters_dhc = runMultiStarts(objectiveFunction, 1, n_starts, 'dhc', 4, lb, ub);
% printResultParameters(parameters_dhc);
% 
% disp('dhc2:');
% parameters_dhc2 = runMultiStarts(objectiveFunction, 1, n_starts, 'dhc', 4, lb, ub, 2);
% printResultParameters(parameters_dhc2);
% 
% disp('dhc2:');
% parameters_dhc2 = runMultiStarts(objectiveFunction, 1, n_starts, 'dhc', 4, lb, ub, 2);
% printResultParameters(parameters_dhc2);
% 
% disp('dhc3:');
% parameters_dhc3 = runMultiStarts(objectiveFunction, 1, n_starts, 'dhc', 4, lb, ub, 3);
% printResultParameters(parameters_dhc3);
% 
% disp('bobyqa:');
% parameters_bobyqa = runMultiStarts(objectiveFunction, 1, n_starts, 'bobyqa', 4, lb, ub);
% printResultParameters(parameters_bobyqa);

% save('data_ec.mat');

function parameters = runMultiStarts(objectiveFunction, objOutNumber, nStarts, localOptimizer, nPar, parMin, parMax, varargin)
    clearPersistentVariables();
    
    tol = 1e-10;
    numevals = 100*nPar;
    
    options = PestoOptions();
    options.obj_type = 'log-posterior';
    options.comp_type = 'sequential';
    options.n_starts = nStarts;
    options.objOutNumber = objOutNumber;
    options.mode = 'visual';
    options.localOptimizer = localOptimizer;
    options.localOptimizerOptions.GradObj="on";
    options.localOptimizerOptions.TolX          = tol;
    options.localOptimizerOptions.TolFun        = tol;
    options.localOptimizerOptions.MaxFunEvals   = numevals;
    options.localOptimizerOptions.MaxIter       = numevals;
    if nargin > 7, options.localOptimizerOptions.Mode          = varargin{1}; end
    if (isequal(localOptimizer,'hctt')), options.localOptimizerOptions.Barrier = 'log-barrier'; end
    
    % for fmincon
    options.localOptimizerOptions.MaxFunctionEvaluations = numevals;
    options.localOptimizerOptions.MaxIterations = numevals;
    options.localOptimizerOptions.StepTolerance = tol;
    options.localOptimizerOptions.Display = 'iter';
    
    options.localOptimizerOptions.Lb = parMin;
    options.localOptimizerOptions.Ub = parMax;
    options.localOptimizerOptions.Tol = 1e-6;
%     options.localOptimizerOptions.Barrier = 'log-barrier';
    
    parameters.number = nPar;
    parameters.min = parMin;
    parameters.max = parMax;
    
    parameters = getMultiStarts(parameters, objectiveFunction, options);
    
end