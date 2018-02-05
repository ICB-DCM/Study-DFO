clear;
clear persistent;
close all;

addpath('../models_sysbio/mRNA_transfection');
dirname = 'res_mt';
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
% We fix a data set. It consists of a vector of time points t and a
% measurement vector ym. This data is taken from the referenced publication.

t = (0:0.2:10)';
ym = [   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   1.8309
   3.3559
   4.6091
   5.4235
   5.9757
   6.6298
   7.0080
   7.8280
   7.5852
   7.9247
   7.8363
   8.0107
   7.7077
   7.5316
   7.4208
   7.5734
   7.3197
   7.1489
   7.1987
   6.8493
   6.6425
   6.6268
   6.1223
   6.1078
   5.9242
   5.6034
   5.4618
   5.1281
   4.9489
   4.8930
   4.7747
   4.7750
   4.3095
   4.2211
   4.0416
   3.7485
   3.7164
   3.4799
   3.5286
   3.2785];

%% Definition of the Parameter Estimation Problem
% In order to run any PESTO routine, at least the parameters struct with
% the fields shown here and the objective function need to be defined,
% since they are mandatory for getMultiStarts, which is usually the first
% routine needed for any parameter estimation problem.
% In this case, also a properties struct is created. For this struct,
% basically the same routines can be called as for the parameters, just the
% naming is different. Therefore, basically the same fields as for the
% parameters struct have to be created.

% Parameters
t = (0:0.2:10)';
lb    = [-2; -5; -5; -5; -2];
ub    = [log10(max(t)); 5; 5; 5; 2];
nPar = 5;

% Objective function (Log-likelihood)
objectiveFunction = @(theta) logLikelihoodT(theta, t, ym);

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
save(['res_mt/test_mt_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradtext],'parameters_res');

end % function
