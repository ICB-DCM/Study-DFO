function [] = runEstimation_BachmannJakStat(approach,distribution)

% addpath(genpath('/home/icb/carolin.loos/PhD/PESTOGit'))
% addpath(genpath('/home/icb/carolin.loos/PhD/AMICIGit'))
% addpath(genpath('/home/icb/carolin.loos/PhD/HierarchicalOptimization'))
% addpath(genpath(pwd))

options.llh.approach = approach;
options.llh.distribution = distribution;

options.llh.modeltype = 'reduced';
options.llh.linRNA = true;
options.llh.original = false;
options.llh.save_analytical = false;
options.llh.reduced_woinit = false;

parameters = loadBachmannParameters(options.llh.approach,options.llh.modeltype);
parameters.number = numel(parameters.name);
parameters.min = -3*ones(parameters.number,1);
parameters.max = 3*ones(parameters.number,1);

parameters.max(1) = 4; %CISEqc
parameters.max(3) = 12; %CISInh
parameters.max(7) = 4; %EpoRActJAK2
parameters.max(8) = 6; %EpoRCISInh
parameters.max(10) = 9; %JAK2ActEpo
parameters.max(11) = 4; %JAK2EpoRDeaSHP1
parameters.max(20) = 4;
parameters.min(28:end) = -5; %offsets

load data_Bachmann
D = getOffsetScalingStd_Bachmann(D,options.llh.modeltype);
D = loadInitialConditions(D,options.llh.modeltype);

for cond = 1:numel(D)
    D(cond).my(:,[1:10,12:end],:) = 10.^D(cond).my(:,[1:10,12:end],:);
end
D(3).my = D(3).my - 1;

if strcmp(approach,'hierarchical')
        for i = [1:10,18:20]
            options.llh.obs(i).scale = 'log10';
        end
        for i = [11:17]
            options.llh.obs(i).scale = 'lin';
        end
        for i = [1:6,12:20]
            options.llh.obs(i).scaling = 'single';
            options.llh.obs(i).noise = 'single';
        end
        for i = 7:11
            options.llh.obs(i).scaling = 'absolute';
            options.llh.obs(i).noise = 'single';
        end
        for i = 1:20
            options.llh.obs_groups.scaling{i} = i;
        end
        options.llh.obs_groups.noise = {[1,2],[3,19,20],4,[5,6],7,8,9,10,11,[12,13,14,15,16,17],18};
        options.llh.exp_groups.scaling = {1,2,3,[4,5],6,[7,8],[9,10],[11,12],[13,14],...
            [15:19],[20:25],[26:31],[32:36]};
        checkValidityOptions(D,options.llh)
end

% xi = getParameterGuesses(parameters,@(xi) loglikelihood_Bachmann(xi,D,options),...
%      1, parameters.min, parameters.max);
% [g,g_fd_f,g_fd_b,g_fd_c] = testGradient(xi,@(xi) loglikelihood_Bachmann(xi,D,options),1e-5);
% [g,g_fd_f,g_fd_b,g_fd_c]

options.MS = PestoOptions();
options.MS.localOptimizerOptions = optimset('algorithm','interior-point',...
    'display','iter',...
    'GradObj','on',...
    'MaxIter',5000,...
    'TolFun',1e-10,...
    'TolX',1e-10,...
    'MaxFunEvals',40000,...
    'PrecondBandWidth', inf);

options.MS.comp_type = 'sequential';
options.MS.n_starts = 20; % 100;
options.MS.save = true;
options.MS.foldername = ['results_BachmannJakStat_' approach '_' distribution];

load parameter_guesses_Bachmann par0
parameters.guess = par0(1:parameters.number,1:100);
parameters = getMultiStarts(parameters,@(xi) loglikelihood_Bachmann(xi,D,options),options.MS);
save(options.MS.foldername)

