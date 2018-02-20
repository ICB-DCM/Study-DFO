% % gather all results in one big cell array
% % solvers = {'bobyqa','cmaes','dhc','fmincon','gps','gss','mads','imfil','mcs','meigo-ess-bobyqa','meigo-ess-dhc-old','meigo-ess-dhc','meigo-ess-fmincon','particleswarm','pswarm','rcs','simulannealbnd'};
% solvers_local = C.cell_solvers_local;
% solvers_global = C.cell_solvers_global;
% cell_results_all = cell(0);
% for j=1:length(solvers_local)
%     solver = solvers_local{j};
%     if any(strcmp(solver,{'gss'}))
%         continue;
%     end
%     file = ['results/cell_results_test_' solvers_local{j} '_2000_20_.mat'];
%     if exist(file,'file')
%         load(file);
%         cell_results_all = vertcat(cell_results_all,cell_results);
%     end
% end
% for j=1:length(solvers_global)
%     file = ['results/cell_results_test_' solvers_global{j} '_40000_1_.mat'];
%     if exist(file,'file')
%         load(file);
%         cell_results_all = vertcat(cell_results_all,cell_results);
%     end
% end
% 
% % pre-processing
% cell_results_all = EvaluationHelper.f_preprocess(cell_results_all);
% 
% % get best results
% cell_results_best = EvaluationHelper.f_extractBestResults(cell_results_all);
% 
% % for j=1:length(cell_results_best), cell_results_best{j}.printTiny(); end
% 
% % how many solutions did the algorithms find?
% map_shares = EvaluationHelper.f_getSolvedFraction(cell_results_best);
% 
% % and avgd over all iterates?
% map_shares_all = EvaluationHelper.f_getSolvedFraction(cell_results_all);
% 
% % what about smooth/unimodal?
% cell_results_best_smooth = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,1,2,2);
% map_shares_smooth = EvaluationHelper.f_getSolvedFraction(cell_results_best_smooth);
% 
% cell_results_best_nonsmooth = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,0,2,2);
% map_shares_nonsmooth = EvaluationHelper.f_getSolvedFraction(cell_results_best_nonsmooth);
% 
% cell_results_best_convex = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,2,1,2);
% map_shares_convex = EvaluationHelper.f_getSolvedFraction(cell_results_best_convex);
% 
% cell_results_best_nonconvex = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,2,0,2);
% map_shares_nonconvex = EvaluationHelper.f_getSolvedFraction(cell_results_best_nonconvex);
% 
% cell_results_best_unimodal = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,2,2,1);
% map_shares_unimodal = EvaluationHelper.f_getSolvedFraction(cell_results_best_unimodal);
% 
% cell_results_best_multimodal = EvaluationHelper.f_getAllHaving(cell_results_best,-1,Inf,2,2,0);
% map_shares_multimodal = EvaluationHelper.f_getSolvedFraction(cell_results_best_multimodal);
% 
% % and over all
% cell_results_all_smooth = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,1,2,2);
% map_shares_all_smooth = EvaluationHelper.f_getSolvedFraction(cell_results_all_smooth);
% 
% cell_results_all_nonsmooth = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,0,2,2);
% map_shares_all_nonsmooth = EvaluationHelper.f_getSolvedFraction(cell_results_all_nonsmooth);
% 
% cell_results_all_convex = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,2,1,2);
% map_shares_all_convex = EvaluationHelper.f_getSolvedFraction(cell_results_all_convex);
% 
% cell_results_all_nonconvex = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,2,0,2);
% map_shares_all_nonconvex = EvaluationHelper.f_getSolvedFraction(cell_results_all_nonconvex);
% 
% cell_results_all_unimodal = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,2,2,1);
% map_shares_all_unimodal = EvaluationHelper.f_getSolvedFraction(cell_results_all_unimodal);
% 
% cell_results_all_multimodal = EvaluationHelper.f_getAllHaving(cell_results_all,-1,Inf,2,2,0);
% map_shares_all_multimodal = EvaluationHelper.f_getSolvedFraction(cell_results_all_multimodal);
% 
% % what about dim?
% cell_cell_results_best_dim = cell(C.nDims,1);
% cell_map_best_dim_shares = cell(C.nDims,1);
% for j=1:C.nDims
%     cell_cell_results_best_dim{j} = EvaluationHelper.f_getAllHaving(cell_results_best,C.arr_dims(j),C.arr_dims(j),2,2,2);
%     cell_map_best_dim_shares{j} = EvaluationHelper.f_getSolvedFraction(cell_cell_results_best_dim{j});
% end
% 
% % and over all, and time and fevals
% cell_cell_results_all_dim = cell(C.nDims,1);
% cell_map_all_dim_shares = cell(C.nDims,1);
% cell_map_all_dim_time   = cell(C.nDims,1);
% cell_map_all_dim_fevals = cell(C.nDims,1);
% for j=1:C.nDims
%     cell_cell_results_all_dim{j} = EvaluationHelper.f_getAllHaving(cell_results_all,C.arr_dims(j),C.arr_dims(j),2,2,2);
%     cell_map_all_dim_shares{j} = EvaluationHelper.f_getSolvedFraction(cell_cell_results_all_dim{j});
%     cell_map_all_dim_time{j}   = EvaluationHelper.f_getAverageTimePerAlg(cell_cell_results_all_dim{j});
%     cell_map_all_dim_fevals{j} = EvaluationHelper.f_getAverageFevalsPerAlg(cell_cell_results_all_dim{j});
% end
% 
% %% save data
% 
% save('results/maps_evaluate_multistart','map_shares','map_shares_all','map_shares_smooth','map_shares_nonsmooth','map_shares_convex','map_shares_nonconvex','map_shares_unimodal','map_shares_multimodal',...
%     'map_shares_all_smooth','map_shares_all_nonsmooth','map_shares_all_convex','map_shares_all_nonconvex','map_shares_all_unimodal','map_shares_all_multimodal',...
%     'cell_map_best_dim_shares','cell_map_all_dim_shares','cell_map_all_dim_time','cell_map_all_dim_fevals');

%% load data

load('results/maps_evaluate_multistart');

%% visualize
cell_keys = keys(map_shares);
nKeys = length(cell_keys);

colors = distinguishable_colors(nKeys);
markers = {'o','+','*','.','x','s','d','^','v','<','>','p','h','o','+','*','.','x','s','d','^','v','<','>','p','h','o','+','*','.','x','s','d','^','v','<','>','p','h'};
markers = markers(1:nKeys);
axes('NextPlot','replacechildren', 'ColorOrder',colors); 

legendon = 'off';

% smoothness, convexity, modality

% nColumns = 7;
% v_x = 1:nColumns;
% v_y = zeros(nKeys,nColumns);
% cell_maps = {map_shares,map_shares_smooth,map_shares_nonsmooth,map_shares_convex,map_shares_nonconvex,map_shares_unimodal,map_shares_multimodal};
% for j=1:nKeys
%    key_j = cell_keys{j};
%    for k=1:nColumns
%        tmp_map = cell_maps{k};
%        v_y(j,k) = tmp_map(key_j);
%    end
% end
% % sort
% [v_y,index] = sortrows(v_y,1,'descend');
% cell_keys_tmp = cell_keys(index);
% colors_tmp = colors(index,:);
% markers_tmp = markers(index);
% %display
% fig = figure('name','smooth-convex-unimodal');
% hold on;
% for j=1:nKeys
%     plot(v_x,v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
% end
% hold off;
% legend(legendon,'Location','northeastoutside');
% xticks(1:nColumns);
% xticklabels({'all','smooth','nonsmooth','convex','nonconvex','unimodal','multimodal'});
% xlabel('function category');
% ylabel('solved problems [%]');
% ylim([0,1]);
% pbaspect([1 1 1]);
% saveas(fig, [pwd '/images/smooth-convex-unimodal.png']);

nColumns = 5;
v_x = 1:nColumns;
v_y = zeros(nKeys,nColumns);
cell_maps = {map_shares,map_shares_smooth,map_shares_nonsmooth,map_shares_convex,map_shares_nonconvex};
for j=1:nKeys
   key_j = cell_keys{j};
   for k=1:nColumns
       tmp_map = cell_maps{k};
       v_y(j,k) = tmp_map(key_j);
   end
end
v_y_smooth_convex_multistart = v_y;
% sort
[v_y,index] = sortrows(v_y,1,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
%display
fig = figure('name','smooth-convex-lg');
hold on;
for j=1:nKeys
    plot(v_x,100*v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
hold off;
legend(legendon,'Location','northeastoutside');
xticks(1:nColumns);
xticklabels({'all','smooth','nonsmooth','convex','nonconvex'});
xlabel('function category');
ylabel('solved problems [%]');
ylim([0,100]);
pbaspect([1 1 1]);
saveas(fig, [pwd '/images/smooth-convex-lg.png']); 

% and for all
cell_keys = keys(map_shares_all);
nKeys = length(cell_keys);

nColumns = 5;
v_x = 1:nColumns;
v_y = zeros(nKeys,nColumns);
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
fig = figure('name','smooth-convex-all-lg');
hold on;
for j=1:nKeys
    plot(v_x,100*v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
hold off;
legend(legendon,'Location','northeastoutside');
xticks(1:nColumns);
xticklabels({'all','smooth','nonsmooth','convex','nonconvex'});
xlabel('function category');
ylabel('solved problems [%]');
ylim([0,100]);
pbaspect([1 1 1]);
saveas(fig, [pwd '/images/smooth-convex-all-lg.png']); 

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
[v_y,index] = sortrows(v_y,1,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
fig = figure('name','dims-lg');
hold on;
for j=1:nKeys
    plot(v_x,100*v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
hold off;
legend(legendon,'Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dimension');
ylabel('solved problems [%]');
ylim([0,100]);
xlim([1,C.nDims]);
pbaspect([1 1 1]);
saveas(fig, [pwd '/images/dims-lg.png']); 

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
[v_y,index] = sortrows(v_y,1,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
fig = figure('name','dims-all-lg');
hold on;
for j=1:nKeys
    plot(v_x,100*v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
hold off;
legend(legendon,'Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dimension');
ylabel('solved problems [%]');
ylim([0,100]);
xlim([1,C.nDims]);
pbaspect([1 1 1]);
saveas(fig, [pwd '/images/dims-all-lg.png']); 

% time
v_x = 1:C.nDims;
v_y = zeros(nKeys,1);
for j=1:nKeys
    key_j = cell_keys{j};
   for k=1:C.nDims
       tmp_map = cell_map_all_dim_time{k};
       v_y(j,k) = tmp_map(key_j);
   end
end
[v_y,index] = sortrows(v_y,1,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
fig = figure('name','time-lg');
for j=1:nKeys
    semilogy(v_x,v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
    hold on;
end
hold off;
legend(legendon,'Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dimension');
ylabel('avg. time [s]');
xlim([1,C.nDims]);
pbaspect([1 1 1]);
saveas(fig, [pwd '/images/time-lg.png']);

% fevals
v_x = 1:C.nDims;
v_y = zeros(nKeys,1);
for j=1:nKeys
    key_j = cell_keys{j};
   for k=1:C.nDims
       tmp_map = cell_map_all_dim_fevals{k};
       v_y(j,k) = tmp_map(key_j);
   end
end
[v_y,index] = sortrows(v_y,1,'descend');
cell_keys_tmp = cell_keys(index);
colors_tmp = colors(index,:);
markers_tmp = markers(index);
fig = figure('name','fevals-lg');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers_tmp{j} '-'], 'DisplayName', cell_keys_tmp{j}, 'color', colors_tmp(j,:)); 
end
plot(1:C.nDims,C.maxFunEvals{2}*ones(1,C.nDims),'-r','DisplayName','maxFunEvals (global)');
plot(1:C.nDims,C.maxFunEvals{1}*ones(1,C.nDims),'-r','DisplayName','maxFunEvals (local)');
hold off;
legend(legendon,'Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dim');
ylabel('avg. function evaluations');
xlim([1,C.nDims]);
pbaspect([1 1 1]);
saveas(fig, [pwd '/images/fevals-lg.png']);

