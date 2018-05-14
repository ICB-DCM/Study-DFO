clear;
clear persistent;
close all;

addpath(genpath('../models_sysbio/Pom1p_gradient_formation'));
dirname = 'res_pom';
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
parameters_meigo_dhc = test('meigo-ess-dhc',maxFunEvals,nStarts);
parameters_meigo_bobyqa = test('meigo-ess-bobyqa',maxFunEvals,nStarts);
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
% load data provided in Saunders et. al (2011)
% absolute file paths can be used instead of relative ones
options.optionsLogPost.Estdata{1} = load('FigureS5A.mat');
options.optionsLogPost.Estdata{2} = load('FigureS5C.mat');
options.optionsLogPost.Estdata{3} = load('FigureS5D.mat');
options.optionsLogPost.Estdata{4} = load('Figure1C.mat');

%% GENREAL PARAMETERS
options.startdate = datestr(now,'yyyy-mm-dd');
options.starttime = datestr(now,'HH-MM');

% choose gradient formation model
% 'SDD' : source diffusion degradation model
% 'NLIC': non-linear clustering model
% 'AP'  : autophosphorylation model
% 'MSP' : multi-site phosphorylation model
model = 'MSP'; % 'SDD';

%% parameters
switch model
    case 'SDD'
        % Set 5 basic kinetic parameters
        parameters_est.number = 7;
        parameters_est.guess = log10(exp([-0.5,-3,5,-2,-7.184617366,-9.44,-8.69]')); %log
        parameters_est.min = [  -2,  -5,  0,   -1.5,   -5,   -5, -5]';
        parameters_est.max = [   2,   2,  4,      2,   -2,   -2, -2]';
        parameters_est.name = {'D','mu','J','w_tea','s_1','s_2','s_3'};
        Pom1p_SDD_wrap;
    case 'MSP'
        % Set 5 basic kinetic parameters
        parameters_est.number = 7;
        parameters_est.guess = log10(exp([-1.8,-9,6,-1.45,-7.133,-9.44,-8.69]'));
        parameters_est.min = [  -2, -5,  0,   -1.5,   -5,   -5, -5]';
        parameters_est.max = [   2,  2,  4,      2,   -2,   -2, -2]';
        parameters_est.name = {'D','a','J','w_tea','s_1','s_2','s_3'};
%         Pom1p_MSP_wrap;
    case 'AP'
        % Set 6 basic kinetic parameters
        parameters_est.number = 9;
        parameters_est.guess = log10(exp([-2,-4,-2,-1.7, 5, 0,-6.1836,-8.7,-8]'));
        parameters_est.min =   [-2,  -5,  -5, -5,  0,   -1.5,   -5,   -5, -5]';
        parameters_est.max =   [ 2,   0,   2,  2,  4,      2,   -2,   -2, -2]';
        parameters_est.name = {'D','xi','mu','a','J','w_tea','s_1','s_2','s_3'};
        Pom1p_AP_wrap;
    case 'NLIC'
        % Set 7 basic kinetic parameters
        parameters_est.number = 12;
        parameters_est.guess = log10(exp([-2,-4,-5,-10,-10,log(0.9),4,-1.45,0.6,-8.3705,-8.5,-7.6]'));
        parameters_est.min = [ -2,  -5,  - 5, -5, -5, -8,  0,   -1.5,  1.2,  -5, -5, -5]';
        parameters_est.max = [  2,   0,    2,  2,  2,  0,  4,      2,    3,  -2, -2, -2]';
        parameters_est.name = {'D','xi','mu','a','b','e','J','w_tea','s_c','s_1','s_2','s_3'};
        Pom1p_NLIC_wrap;
end

lb = parameters_est.min;
ub = parameters_est.max;
nPar = parameters_est.number;

%% Set-up pde grid
% grid: -7:7 with 0.1, R = 1.75
% equidistant grid
% Changes in the grid have to be carried out in the model files as well!

p = linspace(-7,7,200);
options.optionsLogPost.disc = struct('p',p);

%% LIKELIHOOD OPTIONS
options.optionsLogPost.counter = 'false';
options.optionsLogPost.grad_ind = (1:parameters_est.number)';
options.optionsLogPost.name = parameters_est.name;
options.optionslogPost.plot = 'true';
options.optionsLogPost.model_type = model;

% log-likelihood function
objectiveFunction = @(theta) logLikelihoodPom1(theta,options.optionsLogPost);

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
save(['res_pom/test_pom_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradtext],'parameters_res');

end % function
