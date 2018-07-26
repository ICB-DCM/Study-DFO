files = dir('results/cell_results_*.mat')

sum_time = 0;

for file = files
    load(file.name);
    for jResult = 1:length(cell_results)
        sum_time = sum_time + cell_results{jResult}.time;
    end
end
