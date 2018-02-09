solvers = horzcat(C.cell_solvers_local,C.cell_solvers_global);
for j=1:length(solvers)
    file = ['results_big/cell_results_test_' solvers{j} '_2000_20_.mat'];
    if exist(file,'file')
        load(file);
        for k=1:length(cell_results)
            result = cell_results{k};
            result.fval_trace = [];
            cell_results{k} = result;
        end
        save(['results/cell_results_test_' solvers{j} '_2000_20_.mat'],'cell_results');
    end
end

solvers = horzcat(C.cell_solvers_local,C.cell_solvers_global);
for j=1:length(solvers)
    file = ['results_big/cell_results_test_' solvers{j} '_40000_1_.mat'];
    if exist(file,'file')
        load(file);
        for k=1:length(cell_results)
            result = cell_results{k};
            result.fval_trace = [];
            cell_results{k} = result;
        end
        save(['results/cell_results_test_' solvers{j} '_40000_1_.mat'],'cell_results');
    end
end

solvers = horzcat(C.cell_solvers_local,C.cell_solvers_global);
for j=1:length(solvers)
    file = ['results_big/cell_results_test_' solvers{j} '_2000_20_noise_.mat'];
    if exist(file,'file')
        load(file);
        for k=1:length(cell_results)
            result = cell_results{k};
            result.fval_trace = [];
            cell_results{k} = result;
        end
        save(['results/cell_results_test_' solvers{j} '_2000_20_noise_.mat'],'cell_results');
    end
end