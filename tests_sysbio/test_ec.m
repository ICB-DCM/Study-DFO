clear;
clear persistent;
close all;

addpath('../models_sysbio/enzymatic_catalysis');
dirname = 'res_ec';
if ~exist(dirname,'dir')
    mkdir(dirname);
end

maxFunEvals = 500; % relative, multiplied by problem dim
nStarts = 100;

parameters_fmincon = test('fmincon',maxFunEvals,nStarts);
parameters_fmincon_gradient = test('fmincon',maxFunEvals,nStarts,true);
parameters_dhc = test('dhc',maxFunEvals,nStarts);
parameters_rcs = test('rcs',maxFunEvals,nStarts);
parameters_bobyqa = test('bobyqa',maxFunEvals,nStarts);
parameters_mcs = test('mcs',maxFunEvals,nStarts);
parameters_direct = test('direct',maxFunEvals,nStarts);
parameters_meigo = test('meigo-ess',maxFunEvals,nStarts);
parameters_meigo_gradient = test('meigo-ess',maxFunEvals,nStarts,true);
parameters_cmaes = test('cmaes',maxFunEvals,nStarts);
parameters_pswarm = test('pswarm',maxFunEvals,nStarts);
parameters_hybrid1 = test('hybrid-snobfit',maxFunEvals,nStarts);
parameters_hybrid2 = test('hybrid-mcs',maxFunEvals,nStarts);
parameters_hybrid3 = test('hybrid-simple',maxFunEvals,nStarts);

function [parameters_res] =  test(solver,maxFunEvals,nStarts,useGradient)

if nargin < 4
    useGradient = false;
end
disp(solver);

addpath(genpath('../algorithms'));

% Seed the random number generator. Seeding the random number generator
% ensures that everytime this example is run, the same sequence of random
% numbers is generated, and thus, the same starting points for multi-start
% optimization will be used. This is helpful for debugging or comparing
% results across different machines.
% Results might vary though if PestoOptions.comp_type is set to 'parallel'
rng('default');
rng(0);

%% Artificial Data for Parameter Estimation
% The necessary variables are set (Parameter bounds, variance, ...)
nTimepoints = 50;      % Time points of Measurement
nMeasure    = 1;        % Number of experiments
sigma2      = 0.05^2;   % Variance of Measurement noise
lowerBound  = -10;      % Lower bound for parameters
upperBound  = 5;        % Upper bound for parameters
% theta       = [1.1770; -2.3714; -0.4827; -5.5387]; % True parameter values

nPar = 4;
lb = lowerBound * ones(4,1);
ub = upperBound * ones(4,1);

% The measurement data is read out from the files where it is saved
yMeasured = getMeasuredDataEC();
con0 = getInitialConcentrationsEC();

% objective function
objectiveFunction = @(theta) logLikelihoodEC(theta, yMeasured, sigma2, con0, nTimepoints, nMeasure);

%% Optimization

% Optimization
parameters_res = runMultiStarts(objectiveFunction, maxFunEvals, nStarts, solver, nPar, lb, ub, useGradient);
printResultParameters(parameters_res);

if useGradient
    gradtext = '_gradient';
else
    gradtext = '';
end
save(['res_ec/test_ec_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradtext],'parameters_res');

end % function
