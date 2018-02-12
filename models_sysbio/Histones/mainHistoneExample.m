% Main file of the Histone Example

clear all;
close all;
clc;

% Wrap models
[exdir,~,~]=fileparts(which('mainHistoneExample.m'));
amiwrap('histonesPre','histones_preequ_Zheng_syms', exdir);
amiwrap('histones','histones_Zheng_syms', exdir);

% Write parameter struct
parameters.name = {'inflow','k00_01','k00_10','k01_0','k01_02','k01_11','k02_01',...
    'k02_03','k02_12','k03_02','k03_13','k10_00','k10_11','k10_20','k11_01','k11_10',...
    'k11_12','k11_21','k12_02','k12_11','k12_13','k12_22','k13_03','k13_12',...
    'k13_23','k20_10','k20_21','k20_30','k21_11','k21_20','k21_22','k21_31',...
    'k22_12','k22_21','k22_23','k22_32','k23_13','k23_22','k30_20','k30_31',...
    'k31_21','k31_30','k31_32','k32_22','k32_31','\sigma^2'};
parameters.number = length(parameters.name);
parameters.min = -8*ones(parameters.number,1);
parameters.max = 4*ones(parameters.number,1);

tol = 1e-12;

% Set Pesto options
options = PestoOptions();
options.mode = 'text';
options.localOptimizer = 'fmincon';
options.localOptimizerOptions.Display = 'iter';
options.localOptimizerOptions.TolX = tol;
options.localOptimizerOptions.TolFun = tol;
options.localOptimizerOptions.TolGrad = 1e-5;
options.localOptimizerOptions.MaxIter = 1200;
options.localOptimizerOptions.GradObj = 'on';
options.n_starts = 50;

% Set Data
load('data_Zheng.mat');
amiD = struct(...
    't', D.t, ...
    'Y', D.y, ...
    'condition', []);
amiData = amidata(amiD);

% Set objective function
objectiveFunction = @(theta) logLikelihoodHistones(theta, amiData);

% Run optimization
disp('runnin runnin runnin runnin runnin ...');
time = datestr(datetime('now'),'yymmddhh');

% parameters_fmincon = getMultiStarts(parameters, objectiveFunction, options);
% save(['parameters_fmincon-' time '.mat'], 'parameters_fmincon','options');

options.localOptimizerOptions.MaxFunEvals = 10000*parameters.number;
options.localOptimizerOptions.MaxIter     = 10000*parameters.number;

options.localOptimizer = 'dhc';

% parameters_dhc = getMultiStarts(parameters, objectiveFunction, options);
% save(['parameters_dhc-' time '.mat'], 'parameters_dhc','options');

options.localOptimizerOptions.Rhoend = tol;
options.localOptimizer = 'bobyqa';
parameters_bobyqa = getMultiStarts(parameters, objectiveFunction, options);
save(['parameters_bobyqa-' time '.mat'], 'parameters_bobyqa','options');

save workspaceHist;