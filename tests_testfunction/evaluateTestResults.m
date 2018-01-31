close all;

% gather all results in one big cell array
solvers = {'bobyqa','cmaes','dhc','fmincon','gps','gss','mads','imfil','mcs','meigo-ess-bobyqa','meigo-ess-dhc-old','meigo-ess-dhc','meigo-ess-fmincon','particleswarm','pswarm','rcs','simulannealbnd'};
cell_results_all = cell(0);
for j=1:length(solvers)
    load(['cell_results_test_' solvers{j}]);
    cell_results_all = vertcat(cell_results_all,cell_results);
end
load('cell_results_test_fmincon.mat');
cell_results_fmincon = cell_results;
load('cell_results_test_dhc.mat');
cell_results_dhc = cell_results;
load('cell_results_test_rcs.mat');
cell_results_rcs = cell_results;

% add information
cell_results_all = EvaluationHelper.f_createResultExtendedList(cell_results_all);

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

markers = {'o','+','*','.','x','s','d','^','v','<','>','p','h'};
nMarkers = length(markers);
colors  = {'r','m','c','g','b','k'};
nColors = length(colors);

% TextSizes.DefaultAxesFontSize = 14;
% TextSizes.DefaultTextFontSize = 18;
% set(0,TextSizes);

% smooth, unimodal
cell_keys = keys(map_shares);
nKeys = length(cell_keys);

v_x = 1:5;
v_y = zeros(nKeys,5);
cell_maps = {map_shares,map_shares_smooth,map_shares_nonsmooth,map_shares_convex,map_shares_nonconvex};
for j=1:nKeys
   for k=1:5
       tmp_map = cell_maps{k};
       tmp_keys = keys(tmp_map);
       v_y(j,k) = tmp_map(tmp_keys{j});
   end
end
fig = figure('name','smooth/modal');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers{mod(j,nMarkers)+1} colors{mod(j,nColors)+1} '-'], 'DisplayName', cell_keys{j}); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:5);
xticklabels({'all','smooth','nonsmooth','convex','nonconvex'});
xlabel('function types');
ylabel('solved problems');

saveas(fig, [pwd '/images/smooth-convex.png']); 

% and for all
cell_keys = keys(map_shares_all);
nKeys = length(cell_keys);

v_x = 1:5;
v_y = zeros(nKeys,5);
cell_maps = {map_shares_all,map_shares_all_smooth,map_shares_all_nonsmooth,map_shares_all_convex,map_shares_all_nonconvex};
for j=1:nKeys
   for k=1:5
       tmp_map = cell_maps{k};
       tmp_keys = keys(tmp_map);
       v_y(j,k) = tmp_map(tmp_keys{j});
   end
end
fig = figure('name','smooth/convex (all)');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers{mod(j,nMarkers)+1} colors{mod(j,nColors)+1} '-'], 'DisplayName', cell_keys{j}); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:5);
xticklabels({'all','smooth','nonsmooth','convex','nonconvex'});
xlabel('function types');
ylabel('solved problems');

saveas(fig, [pwd '/images/smooth-convex-all.png']); 

% dims
v_x = 1:C.nDims;
v_y = zeros(nKeys,1);
for j=1:nKeys
   for k=1:C.nDims
       tmp_map = cell_map_best_dim_shares{k};
       tmp_keys = keys(tmp_map);
       v_y(j,k) = tmp_map(tmp_keys{j});
   end
end
fig = figure('name','dims');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers{mod(j,nMarkers)+1} colors{mod(j,nColors)+1} '-'], 'DisplayName', cell_keys{j}); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dim');
ylabel('solved problems');

saveas(fig, [pwd '/images/dims.png']); 

% and for all
v_x = 1:C.nDims;
v_y = zeros(nKeys,1);
for j=1:nKeys
   for k=1:C.nDims
       tmp_map = cell_map_all_dim_shares{k};
       tmp_keys = keys(tmp_map);
       v_y(j,k) = tmp_map(tmp_keys{j});
   end
end
fig = figure('name','dims (all)');
hold on;
for j=1:nKeys
    plot(v_x,v_y(j,:),[markers{mod(j,nMarkers)+1} colors{mod(j,nColors)+1} '-'], 'DisplayName', cell_keys{j}); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dim');
ylabel('solved problems');

saveas(fig, [pwd '/images/dims-all.png']); 

% time
v_x = 1:C.nDims;
v_y = zeros(nKeys,1);
for j=1:nKeys
   for k=1:C.nDims
       tmp_map = cell_map_all_dim_time{k};
       tmp_keys = keys(tmp_map);
       v_y(j,k) = tmp_map(tmp_keys{j});
   end
end
fig = figure('name','time');
hold on;
for j=1:nKeys
    plot(v_x,log10(v_y(j,:)),[markers{mod(j,nMarkers)+1} colors{mod(j,nColors)+1} '-'], 'DisplayName', cell_keys{j}); 
end
hold off;
legend('show','Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dim');
ylabel('log10(avgTime)');

saveas(fig, [pwd '/images/time.png']); 

% fevals
v_x = 1:C.nDims;
v_y = zeros(nKeys,1);
for j=1:nKeys
   for k=1:C.nDims
       tmp_map = cell_map_all_dim_fevals{k};
       tmp_keys = keys(tmp_map);
       v_y(j,k) = tmp_map(tmp_keys{j});
   end
end
fig = figure('name','funEvals');
hold on;
for j=1:nKeys
    plot(v_x,log10(v_y(j,:)),[markers{mod(j,nMarkers)+1} colors{mod(j,nColors)+1} '-'], 'DisplayName', cell_keys{j}); 
end
plot(1:C.nDims,log10(C.maxFunEvals_local)*ones(1,C.nDims),'-r','DisplayName','maxFunEvals-local');
plot(1:C.nDims,log10(C.maxFunEvals_global)*ones(1,C.nDims),'-r','DisplayName','maxFunEvals-global');
hold off;
legend('show','Location','northeastoutside');
xticks(1:C.nDims);
xticklabels(C.arr_dims);
xlabel('dim');
ylabel('log10(avgFunEvals)');

saveas(fig, [pwd '/images/fevals.png']); 
