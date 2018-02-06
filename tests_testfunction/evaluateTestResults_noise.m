close all;
clear;

% gather all results in one big cell array
solvers = horzcat(C.cell_solvers_local,C.cell_solvers_global);
cell_results_all = cell(0);
for j=1:length(solvers)
    file = ['cell_results_test_' solvers{j} '_2000_20_noise_.mat'];
    if exist(file,'file')
        load(file);
        cell_results_all = vertcat(cell_results_all,cell_results);
    end
end

% add information
% cell_results_all = EvaluationHelper.f_createResultExtendedList(cell_results_all);

% get best results
cell_results_best = EvaluationHelper.f_extractBestResults(cell_results_all);

% for j=1:length(cell_results_best), cell_results_best{j}.printTiny(); end

% how many solutions did the algorithms find?
map_shares = EvaluationHelper.f_getSolvedShare(cell_results_best);

% and avgd over all iterates?
map_shares_all = EvaluationHelper.f_getSolvedShare(cell_results_all);

% what about smooth/unimodal?
cell_results_best_smooth = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,1,2,2);
map_shares_smooth = EvaluationHelper.f_getSolvedShare(cell_results_best_smooth);

cell_results_best_nonsmooth = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,0,2,2);
map_shares_nonsmooth = EvaluationHelper.f_getSolvedShare(cell_results_best_nonsmooth);

cell_results_best_convex = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,2,1,2);
map_shares_convex = EvaluationHelper.f_getSolvedShare(cell_results_best_convex);

cell_results_best_nonconvex = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,2,0,2);
map_shares_nonconvex = EvaluationHelper.f_getSolvedShare(cell_results_best_nonconvex);

% and over all
cell_results_all_smooth = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,1,2,2);
map_shares_all_smooth = EvaluationHelper.f_getSolvedShare(cell_results_all_smooth);

cell_results_all_nonsmooth = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,0,2,2);
map_shares_all_nonsmooth = EvaluationHelper.f_getSolvedShare(cell_results_all_nonsmooth);

cell_results_all_convex = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,2,1,2);
map_shares_all_convex = EvaluationHelper.f_getSolvedShare(cell_results_all_convex);

cell_results_all_nonconvex = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,2,0,2);
map_shares_all_nonconvex = EvaluationHelper.f_getSolvedShare(cell_results_all_nonconvex);

% what about dim?
cell_cell_results_best_dim = cell(C.nDims,1);
cell_map_best_dim_shares = cell(C.nDims,1);
for j=1:C.nDims
    cell_cell_results_best_dim{j} = EvaluationHelper.f_getAllHaving(cell_results_best,C.arr_dims(j),C.arr_dims(j),2,2,2);
    cell_map_best_dim_shares{j} = EvaluationHelper.f_getSolvedShare(cell_cell_results_best_dim{j});
end

% and over all, and time and fevals
cell_cell_results_all_dim = cell(C.nDims,1);
cell_map_all_dim_shares = cell(C.nDims,1);
cell_map_all_dim_time   = cell(C.nDims,1);
cell_map_all_dim_fevals = cell(C.nDims,1);
for j=1:C.nDims
    cell_cell_results_all_dim{j} = EvaluationHelper.f_getAllHaving(cell_results_all,C.arr_dims(j),C.arr_dims(j),2,2,2);
    cell_map_all_dim_shares{j} = EvaluationHelper.f_getSolvedShare(cell_cell_results_all_dim{j});
    cell_map_all_dim_time{j}   = EvaluationHelper.f_getAverageTimePerAlg(cell_cell_results_all_dim{j});
    cell_map_all_dim_fevals{j} = EvaluationHelper.f_getAverageFevalsPerAlg(cell_cell_results_all_dim{j});
end

% average time over all runs of each alorithm
map_time = EvaluationHelper.f_getAverageTimePerAlg(cell_results_all);

% text output
% keys(map_shares)
% values(map_shares)
% 
% keys(map_shares_smooth)
% values(map_shares_smooth)
% 
% keys(map_shares_nonsmooth)
% values(map_shares_nonsmooth)
% 
% keys(map_shares_unimodal)
% values(map_shares_multimodal)
% 
% keys(map_shares_multimodal)
% values(map_shares_multimodal)

% time
% keys(map_time)
% values(map_time)



%% visualize
cell_keys = keys(map_shares);
nKeys = length(cell_keys);

colors = distinguishable_colors(nKeys);
markers = {'o','+','*','.','x','s','d','^','v','<','>','p','h','o','+','*','.','x','s','d','^','v','<','>','p','h','o','+','*','.','x','s','d','^','v','<','>','p','h'};
markers = markers(1:nKeys);
% colors  = {'r','m','c','g','b','k'};
nColors = length(colors);
axes('NextPlot','replacechildren', 'ColorOrder',colors); 
% TextSizes.DefaultAxesFontSize = 14;
% TextSizes.DefaultTextFontSize = 18;
% set(0,TextSizes);

% smooth, unimodal


v_x = 1:5;
v_y = zeros(nKeys,5);
cell_maps = {map_shares,map_shares_smooth,map_shares_nonsmooth,map_shares_convex,map_shares_nonconvex};
for j=1:nKeys
   key_j = cell_keys{j};
   for k=1:5
       tmp_map = cell_maps{k};
       v_y(j,k) = tmp_map(key_j);
   end
end
% sort
[v_y,index] = sortrows(v_y,5,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
%display
fig = figure('name','smooth/modal (noise)');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:5);
xticklabels({'all','smooth','nonsmooth','convex','nonconvex'});
xlabel('function types');
ylabel('solved problems');
ylim([0,1]);

saveas(fig, [pwd '/images/smooth-convex-noise.png']); 

% and for all
cell_keys = keys(map_shares_all);
nKeys = length(cell_keys);

v_x = 1:5;
v_y = zeros(nKeys,5);
cell_maps = {map_shares_all,map_shares_all_smooth,map_shares_all_nonsmooth,map_shares_all_convex,map_shares_all_nonconvex};
for j=1:nKeys
   key_j = cell_keys{j};
   for k=1:5
       tmp_map = cell_maps{k};
       v_y(j,k) = tmp_map(key_j);
   end
end
[v_y,index] = sortrows(v_y,1,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
fig = figure('name','smooth/convex (all, noise)');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:5);
xticklabels({'all','smooth','nonsmooth','convex','nonconvex'});
xlabel('function types');
ylabel('solved problems');
ylim([0,1]);

saveas(fig, [pwd '/images/smooth-convex-all-noise.png']); 

% dims
v_x = 1:C.nDims;
v_y = zeros(nKeys,1);
for j=1:nKeys
   key_j = cell_keys{j};
   for k=1:C.nDims
       tmp_map = cell_map_best_dim_shares{k};
       v_y(j,k) = tmp_map(key_j);
   end
end
[v_y,index] = sortrows(v_y,C.nDims,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
fig = figure('name','dims (noise)');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dim');
ylabel('solved problems');
ylim([0,1]);

saveas(fig, [pwd '/images/dims-noise.png']); 

% and for all
v_x = 1:C.nDims;
v_y = zeros(nKeys,1);
for j=1:nKeys
   key_j = cell_keys{j};
   for k=1:C.nDims
       tmp_map = cell_map_all_dim_shares{k};
       v_y(j,k) = tmp_map(key_j);
   end
end
[v_y,index] = sortrows(v_y,C.nDims,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
fig = figure('name','dims (all, noise)');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dim');
ylabel('solved problems');
ylim([0,1]);

saveas(fig, [pwd '/images/dims-all-noise.png']); 
