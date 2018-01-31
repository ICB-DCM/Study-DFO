function cell_results = runTests( solver, maxFunEvals, nStarts, bool_noise )
% INPUT
%   solver: id of the solver
%   maxFunEvals: maximum number of function evaluations
%   nStarts: number of multistarts
%   bool_noise: true = add noise to objective function evaluations,
%               false = do not add noise

% default: no noise
if nargin == 1
    bool_noise = false;
end

%% preliminaries

addpath('../models_testfunction');

% Initialize the random number generator once to ensure reproducibility.
% We do not re-initialize it before each run in order to allow the
% stochasticity of different solvers to take effect.
rng('default');
rng(0);

%% create exercises

cell_exercises = createExercises(solver, maxFunEvals, nStarts, bool_noise);

if bool_noise
    noise = 'noise_';
else 
    noise = '';
end

%% solve exercises

nExercises = length(cell_exercises);

% space for the solutions
cell_results = cell(nExercises,1);

for jExercise = 1:nExercises
    ex = cell_exercises{jExercise};
    fprintf(['solver: ' ex.alg '\t objfun: ' ex.name noise '\t dim: ' num2str(ex.dim) '\n']);
    
    result = doExercise(ex);
    
    fprintf(['xbst: ' num2str(result.fbst) '\t x: ' num2str(result.fval) '\t fevals: ' num2str(result.funEvals) '\n']);
    
    cell_results{jExercise} = result;
end

%% save results

exdir = fileparts(which('runTests.m'));
time = '';%['-',datestr(datetime('now'),'yyyymmddHHMMSS')];
save(fullfile(exdir,['cell_results_test_',solver,'_',num2str(maxFunEvals),'_',num2str(nStarts),'_',noise,time,'.mat']),'cell_results');
end
