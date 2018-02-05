clear;
clear persistent;
close all;

addpath('../models_sysbio/jakstat_signaling');
dirname = 'res_js';
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
%% Data
% Experimental data is read out from an .xls-file and written to an AMICI
% object which is used for the ODE integration
datatable         = xlsread(fullfile('pnas_data_original_js.xls'));
amiData.t         = datatable(:,1);       % time points
amiData.Y         = datatable(:,[2,4,6]); % measurement
amiData.condition = [1.4,0.45];           % initial conditions
amiData.Sigma_Y   = NaN(size(amiData.Y)); % preallocation of variances
amiData           = amidata(amiData);     % calling the AMICI routine

%% Generation of the structs and options for PESTO
% The structs and the PestoOptions object, which are necessary for the 
% PESTO routines to work are created and set to convenient values

% parameters
nPar = 17;
lb     = -5 * ones(nPar,1);
ub     =  3 * ones(nPar,1);
ub(4)  =  6;
ub(2)  =  6;
lb(10) = -6;
lb(4)  = -3;
lb(2)  = -3;

% objective function
objectiveFunction = @(theta) logLikelihoodJakstat(theta, amiData);
if strcmp(solver,'mcs')
    objfun = @(theta) funWrap(objectiveFunction,theta);
else
    objfun = @(theta) objectiveFunction(theta);
end

%% Optimization
% A multi-start local optimization is performed within the bounds defined in
% parameters.min and .max in order to infer the unknown parameters from
% measurement data. Therefore, a PestoOptions object is created and
% some of its properties are set accordingly.

% Optimization
parameters_res = runMultiStarts(objfun, maxFunEvals, nStarts, solver, nPar, lb, ub, useGradient);
printResultParameters(parameters_res);
if useGradient
    gradtext = '_gradient';
else
    gradtext = '';
end
save(['res_js/test_js_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradtext],'parameters_res');

end % function

function fval = funWrap(fun,x)
fval = fun(x);
% fprintf('%.15f\n',fval);
if isnan(fval) ||isinf(fval)
    fval = -e40;
end
end
