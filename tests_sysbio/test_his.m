clear;
clear persistent;
close all;

addpath(genpath('../models_sysbio/Histones'));
dirname = 'res_his';
if ~exist(dirname,'dir')
    mkdir(dirname);
end

maxFunEvals = 1000;
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
parameters_meigo_dhc = test('meigo-ess-dhc',maxFunEvals,nStarts);
parameters_meigo_bobyqa = test('meigo-ess-bobyqa',maxFunEvals,nStarts);
parameters_cmaes = test('cmaes',maxFunEvals,nStarts);
parameters_pswarm = test('pswarm',maxFunEvals,nStarts);
parameters_hybrid1 = test('hybrid-snobfit',maxFunEvals,nStarts);
parameters_hybrid2 = test('hybrid-mcs',maxFunEvals,nStarts);
parameters_hybrid3 = test('hybrid-simple',maxFunEvals,nStarts);

function [parameters_res] = test(solver,maxFunEvals,nStarts,useGradient)

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

load data_Zheng.mat
amiData = struct('t',D.t,'Y',D.y,'condition',[]);
amiData = amidata(amiData);
objfun = @(x) logLikelihoodHistones(x,amiData);

parameters.name = {'inflow','k00_01','k00_10','k01_0','k01_02','k01_11','k02_01',...
    'k02_03','k02_12','k03_02','k03_13','k10_00','k10_11','k10_20','k11_01','k11_10',...
    'k11_12','k11_21','k12_02','k12_11','k12_13','k12_22','k13_03','k13_12',...
    'k13_23','k20_10','k20_21','k20_30','k21_11','k21_20','k21_22','k21_31',...
    'k22_12','k22_21','k22_23','k22_32','k23_13','k23_22','k30_20','k30_31',...
    'k31_21','k31_30','k31_32','k32_22','k32_31','\sigma^2'};
parameters.number = length(parameters.name);
parameters.min = -8*ones(parameters.number,1);
parameters.max = 4*ones(parameters.number,1);

lb = parameters.min;
ub = parameters.max;
nPar = parameters.number;

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
save(['res_his/test_his_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradtext],'parameters_res');

end % function
