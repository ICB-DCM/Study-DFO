function cell_results = runTests( solver, bool_noise )
% INPUT
%   solver: id of the solver
%   bool_noise: true = add noise to objective function evaluations,
%               false = do not add noise

% default: no noise
if nargin == 1
    bool_noise = false;
end

addpath('../tests_testfunction');

%% create exercises

cell_exercises = createExercises(solver, bool_noise);

if bool_noise
    noise = '_noise';
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
    
    fprintf(['xbst: ' num2str(result.fbst) '\t x: ' num2str(result.fval) '\n']);
    
    cell_results{jExercise} = result;
end

exdir = fileparts(which('runTests.m'));
time = '';%['-',datestr(datetime('now'),'yyyymmddHHMMSS')];
save(fullfile(exdir,['cell_results_test_',solver,noise,time,'.mat']),'cell_results');
end
