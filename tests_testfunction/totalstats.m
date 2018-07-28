%cd results

files = dir('results/cell_results_test_*');

sum_time = 0;

for jFile = 1:length(files)
    file = files(jFile);
    load(['results/' file.name]);
    for jResult = 1:length(cell_results)
        sum_time = sum_time + cell_results{jResult}.time;
    end
end

disp(['total time: ' num2str(sum_time) 's = ' num2str(sum_time/3600) 'h = ' num2str(sum_time/3600/24) 'd']);
