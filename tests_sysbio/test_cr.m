clear;
clear persistent;
close all;

addpath('../models_sysbio/conversion_reaction');
dirname = 'res_cr';
if ~exist(dirname,'dir')
    mkdir(dirname);
end

maxFunEvals = 500;
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
parameters_res = runMultiStarts(objectiveFunction, maxFunEvals, nStarts, solver, nPar, lb, ub, useGradient);
printResultParameters(parameters_res);
if useGradient
    gradtext = '_gradient';
else
    gradtext = '';
end
save(['res_cr/test_cr_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradtext],'parameters_res');

end % function

