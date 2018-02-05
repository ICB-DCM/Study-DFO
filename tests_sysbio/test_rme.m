clear;
clear persistent;
close all;

addpath('../models_sysbio/RafMekErk');
dirname = 'res_rme';
if ~exist(dirname,'dir')
    mkdir(dirname);
end

maxFunEvals = 1000;
nStarts = 50;

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

%% Data and options

% Experimental data is read out from an .mat-file and written to an AMICI
% data object which is used for the ODE integration
load('D0.mat');
u = D.conditions;
nU = size(u,1);

% Clean up data and make Amici-readable data out of it
for j = 1 : nU
    amiData(j) = struct(...
        't', D.t{j}, ...
        'condition', D.conditions(j,:), ...
        'Y', D.measurement{j} ...
        );
    amiD(j) = amidata(amiData(j));
end

% Create amioptions-object to not always recreate it in objective function
amiOptions.maxsteps = 2e5;
amiOptions.atol = 1e-16;
amiOptions.rtol = 1e-12;
amiOptions.sensi_meth = 'forward';
amiO = amioption(amiOptions);


%% Generation of the structs and options for PESTO
% The structs and the PestoOptions object, which are necessary for the 
% PESTO routines to work are created and set to convenient values

nPar = 28;

parameters.min = -5 * ones(28,1);
parameters.min(1:6) = -3;
parameters.min(7) = -10;
parameters.min(9) = -7;
parameters.min(10:12) = -3;
parameters.min(13:20) = 0;
parameters.min(21:28) = -3;
parameters.max = 4 * ones(28,1);
parameters.max(1:3) = 5;
parameters.max(4) = 6;
parameters.max(5:12) = 3;
parameters.max(13:20) = 8;
parameters.max(21:28) = 3;
lb = parameters.min;
ub = parameters.max;

% objective Function
objectiveFunction = @(theta) logLikelihoodRafMekErk(theta, amiD, amiO);


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
save(['res_rme/test_rme_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradtext],'parameters_res');

end % function
