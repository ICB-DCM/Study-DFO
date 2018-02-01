% Main file of the enzymatic catalysis example
%
% Demonstrates the use of:
% * getParameterSamples()
% * getMultiStarts()
% * getParameterProfiles()
% * getParameterConfidenceIntervals()
%
% Demonstrates furthermore:
% * how to do sampling without multi-start local optimization beforehand
% * how to use the MEIGO toolbox for optimization (commented)
% * how to compute profile likelihoods via the integration method
% * how to use plotting functions outside the get... routines
% * the reliability of sampling and profiling in the case of
%   non-identifiabilites
% * how to use diagnosis tool (e.g. plotMCMCDiagnosis and
%   plotMultiStartDiagnosis)
%
% This example provides a model for the reaction of a species X_1 to a
% species X_4, which is catalyzed by an enzyme X_2.
%
% * X_1 + X_2 -> X_3, rate = theta_1 * [X_1] * [X_2]
% * X_3 -> X_1 + X_2, rate = theta_2 * [X_3]
% * X_3 -> X_4 + X_2, rate = theta_3 * [X_3]
% * X_4 + X_2 -> X_3, rate = theta_4 * [X_4] * [X_2]
%
% Measurements of [X_1] and [X_4] are provided as: Y = [[X_1]; [X_4]]
%
% This file sets a parameter vector, creates and saves artificial
% measurement data as a time series and performs a multi-start local
% optimization based on these measurements, demonstrating the use of
% getMultiStarts().
%
% Parameter sampling is done first without prior information from
% optimization, then with information from optimization.
%
% Parameter optimization is done using multi-start local optimization.
%
% The Profile likelihoods are calculated by integrating an ODE following
% the profile path using getParameterProfiles with the option
% optionsPesto.profile_method = 'integration'.



%% Preliminary
clear all;
close all;
clc;

TextSizes.DefaultAxesFontSize = 14;
TextSizes.DefaultTextFontSize = 18;
set(0,TextSizes);

% Seed random number generator
rng(0);

%% Model Definition
% See logLikelihood.m for a detailed description

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
if ~exist('getInitialConcentrationsEC.m','file')
    display(' Write new measurement data...');
    performNewMeasurementEC(theta, nMeasure, nTimepoints, sigma2);
end

% The measurement data is read out from the files where it is saved
yMeasured = getMeasuredDataEC();
con0 = getInitialConcentrationsEC();

%% Generation of the structs and options for PESTO
% The structs and the PestoOptions object, which are necessary for the 
% PESTO routines to work are created and set to convenient values

% objective function
objectiveFunction = @(theta) logLikelihoodEC(theta, yMeasured, sigma2, con0, nTimepoints, nMeasure);

%% Perform Multistart optimization
% A multi-start local optimization is performed within the bound defined in
% parameters.min and .max in order to infer the unknown parameters from 
% measurement data.

% The following section uses the MEIGO toolbox with following settings:
% (Install MEIGO from http://gingproc.iim.csic.es/meigom.html and
% uncomment:

% MeigoOptions = struct(...
%     'maxeval', 1000, ...
%     'local', struct('solver', 'fmincon', ...
%     'finish', 'fmincon', ...
%     'iterprint', 0) ...
%     );
% 
% optionsPesto.localOptimizer = 'meigo-ess';
% optionsPesto.localOptimizerOptions = MeigoOptions;
% optionsPesto.n_starts = 1;
% parameters = getMultiStarts(parameters, objectiveFunction, optionsPesto);

disp(['True parameters: ',mat2str(theta)]);

% Options for an alternative multi-start local optimization
display(' Optimizing parameters...');
n_starts = 10;
dim = 4;
lb = lowerBound * ones(4,1);
ub = upperBound * ones(4,1);

disp('fmincon:');
parameters_fmincon = runMultiStarts(objectiveFunction, 1, n_starts, 'mcs', dim, lb, ub);
printResultParameters(parameters_fmincon);

function parameters = runMultiStarts(objectiveFunction, objOutNumber, nStarts, localOptimizer, nPar, parMin, parMax)
%     clearPersistentVariables();
    
    tol = 1e-10;
    numevals = 100*nPar;
    
    options = PestoOptions();
    options.obj_type = 'log-posterior';
    options.comp_type = 'sequential';
    options.n_starts = nStarts;
    options.objOutNumber = 2;
    options.mode = 'text';
    options.localOptimizer = localOptimizer;
    options.localOptimizerOptions.GradObj="on";
%     options.localOptimizerOptions.TolX          = tol;
%     options.localOptimizerOptions.TolFun        = tol;
    options.localOptimizerOptions.MaxFunEvals   = numevals;
    options.localOptimizerOptions.MaxIter       = numevals;
    
    % for fmincon
    options.localOptimizerOptions.MaxFunctionEvaluations = numevals;
    options.localOptimizerOptions.MaxIterations = numevals;
    options.localOptimizerOptions.StepTolerance = tol;
    options.localOptimizerOptions.Display = 'off';
  
    
    parameters.number = nPar;
    parameters.min = parMin;
    parameters.max = parMax;
    
    parameters = getMultiStarts(parameters, objectiveFunction, options);
    
end