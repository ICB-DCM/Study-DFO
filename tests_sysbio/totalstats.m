dirs = {'res_cr', 'res_ec', 'res_hb', 'res_his', 'res_js', 'res_mt', 'res_pom', 'res_rme'};

sum_time = 0;

for jDir = 1:length(dirs)
    files = dir([dirs{jDir} '/test_*']);
    for jFile = 1:length(files)
        file = files(jFile);
        load([dirs{jDir} '/' file.name]);
        sum_time = sum_time + nansum(parameters_res.MS.t_cpu);
    end
end

disp(['total time: ' num2str(sum_time) 's = ' num2str(sum_time/3600) 'h = ' num2str(sum_time/3600/24) 'd']);
