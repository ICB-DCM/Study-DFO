function mainRafMekErk()

TextSizes.DefaultAxesFontSize = 14;
TextSizes.DefaultTextFontSize = 18;
set(0,TextSizes);

% Seed random number generator
rng(0);

%% Model Definition
% The ODE model is set up using the AMICI toolbox. To access the AMICI
% model setup, see rafMekErk_pesto_syms.m

[exdir,~,~]=fileparts(which('rafMekErk_pesto_syms.m'));
try
    amiwrap('rafMekErk_pesto', 'rafMekErk_pesto_syms', exdir);
catch ME
    warning('There was a problem with the AMICI toolbox (available at https:// github.com/ICB-DCM/AMICI), which is needed to run this example file. The original error message was:');
    rethrow(ME);
end


%% Data and options

% Experimental data is read out from an .mat-file and written to an AMICI
% data object which is used for the ODE integration
load('./D0.mat');
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

parameters.number = 28;
parameters.name = {'log_{10}(kdf_Raf)','log_{10}(kp_Raf)','log_{10}(kdp_pMek)',...
                   'log_{10}(kp_pRaf_Mek)','log_{10}(kdp_pErk)','log_{10}(kp_pMek_Erk)',...
                   'log_{10}(K_pErk_inh)','log_{10}(sust_Ras_0)','log_{10}(ts_sust_Ras)',...
                   'log_{10}(ts_trans_Ras)','log_{10}(K_Sora)','log_{10}(K_UO)',... 
                   'log_{10}(scale_pMek_20140430_gel1)','log_{10}(scale_pErk_20140430_gel1)',...
                   'log_{10}(scale_pMek_20140430_gel2)','log_{10}(scale_pErk_20140430_gel2)',...
                   'log_{10}(scale_pMek_20140505_gel1)','log_{10}(scale_pErk_20140505_gel1)',...
                   'log_{10}(scale_pMek_20140505_gel2)','log_{10}(scale_pErk_20140505_gel2)',... 
                   'log_{10}(sigma_pMek_20140430_gel1)','log_{10}(sigma_pErk_20140430_gel1)',...
                   'log_{10}(sigma_pMek_20140430_gel2)','log_{10}(sigma_pErk_20140430_gel2)',...
                   'log_{10}(sigma_pMek_20140505_gel1)','log_{10}(sigma_pErk_20140505_gel1)',...
                   'log_{10}(sigma_pMek_20140505_gel2)','log_{10}(sigma_pErk_20140505_gel2)'...
                   };

% objective Function
objectiveFunction = @(theta) logLikelihoodRafMekErk(theta, amiD, amiO);

% Pesto options
options = PestoOptions();
options.n_starts = 50; 
options.mode     = 'text';
options.proposal = 'latin hypercube';
options.trace    = false;
options.obj_type = 'log-posterior';


% 12 dynamic parameters, 8 scaling parameters, 8 sigma parameters
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

options.localOptimizer = 'fmincon';
options.localOptimizerOptions = optimset(...
    'Algorithm', 'interior-point',...
    'GradObj', 'on',...
    'Display', 'iter', ...
    'MaxIter', 1500,...
    'TolFun', 1e-12, ...
    'TolX', 1e-12, ...
    'MaxFunEvals', 1000*parameters.number);

%% Perform optimization
% A parameters optimization is performed within the bound defined in
% parameters.min and .max in order to infer the unknown parameters from 
% measurement data.

time = datestr(datetime('now'),'yymmddhh');

disp('... fmincon');
parameters_fmincon = getMultiStarts(parameters, objectiveFunction, options);
save(['parameters_fmincon-' time '.mat'], 'parameters_fmincon');
% 
% % adapt parameters
% options.objOutNumber = 1;
% options.localOptimizerOptions.MaxIter = 1000*parameters.number;
% options.localOptimizerOptions.MaxFunEvals = 1000*parameters.number;
% options.localOptimizerOptions.TolX = 1e-12;
% options.localOptimizerOptions.TolFun = 1e-12;
% 
% clear options;
% options.objOutNumber = 1;
% options.n_starts = 10;
% options.localOptimizer = 'meigo-ess';
% options.localOptimizerOptions.inter_save = false;
% options.localOptimizerOptions.maxeval = 5000*parameters.number;
% options.localOptimizerOptions.local.solver = 'fmincon';
% options.localOptimizerOptions.local.finish = 'ydhc';
% options.localOptimizerOptions.local.iterprint = 1; % no output after each iteration
% options.localOptimizerOptions.iterprint = 1;
% options.localOptimizerOptions.plot = 0;
% 
% % disp('... meigo-ess-fmincon');
% % parameters_meigo_essfmincon = getMultiStarts(parameters, objectiveFunction, options);
% % save(['parameters_meigo_essfmincon-' time '.mat'], 'parameters_meigo_essfmincon');
% 
% % disp('... meigo-ess-ydhc');
% % options.localOptimizerOptions.local.solver = 'ydhc';
% % parameters_meigo_essydhc = getMultiStarts(parameters, objectiveFunction, options);
% % save(['parameters_meigo_essydhc-' time '.mat'], 'parameters_meigo_essydhc');
% % 
% disp('... dhc');
% options.localOptimizer = 'dhc';
% options.n_starts = 50;
% options.localOptimizerOptions.ExpandFactor = 3.1;
% options.localOptimizerOptions.ContractFactor = 0.27;
% 
% parameters_dhc = getMultiStarts(parameters, objectiveFunction, options);
% save(['parameters_dhc-' time '.mat'], 'parameters_dhc');
% 
% save workspaceRME;
% 
% end
