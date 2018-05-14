clear;
clear persistent;
close all;

addpath(genpath('../models_sysbio/hopfbifurcation'));
dirname = 'res_hb';
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
parameters_meigo_gradient = test('meigo-ess',maxFunEvals,maxFunEvals,true);
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

load('data_hopfbifurcation.mat','p','D','lb','ub');

nPar = length(p);

objfun = @(x) llh(x, D, @simulate_hopfbifurcation);

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
save(['res_hb/test_hb_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradtext],'parameters_res');

end % function
