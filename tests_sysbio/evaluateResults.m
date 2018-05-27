clear;
close all;

threshold = 3;

cell_solvers = {'bobyqa','dhc','direct','mcs','cmaes','pswarm','meigo-ess-bobyqa','meigo-ess-dhc','fmincon','fmincon'};
cell_solvers_official = {'BOBYQA','DHC','DIRECT','MCS','CMAES','PSWARM','MEIGO-ESS-BOBYQA','MEIGO-ESS-DHC','FMINCON','FMINCON+g'};
cell_gradient = {'',     '',   '',      '',   '',    '',       '',                '',             '',        '_gradient'};

cell_problems = {'cr','ec','mt','pom','hb','js','rme','his'};
cell_problems_official = {'M1','M2','M3','M4','M5','M6','M7','M8'};
cell_maxFunEvals = {500,500,500,500,500,1000,1000,1000};
cell_nStarts = {100,100,100,100,100,100,100,100};
cell_nPar = {2,4,5,7,11,17,28,46};

nSolvers = length(cell_solvers);
nProblems = length(cell_problems);
nStarts = 100;

fig_width = 3.667/2*(0.5/0.667)*8.4;
fig_height = fig_width;
fileformat = 'epsc';
ticklength = 0.04;
ygrid = 'off';

colors = distinguishable_colors(nSolvers);
markers = {'o','+','*','x','s','d','^','v','<','>','p','h','o','+','*','x','s','d','^','v','<','>','p','h','o','+','*','x','s','d','^','v','<','>','p','h'};
markers = markers(1:nSolvers);
axes('NextPlot','replacechildren', 'ColorOrder',colors); 
legendon = 'off';

funEvals = zeros(nProblems,nSolvers,nStarts);
time = zeros(nProblems,nSolvers,nStarts);
time_ss = zeros(nProblems,nSolvers);
nllh = nan(nProblems,nSolvers,nStarts);
bestFoundFval = inf(nProblems,1);

for ip = 1:nProblems
    problem = cell_problems{ip};
    maxFunEvals = cell_maxFunEvals{ip};
    nStarts = cell_nStarts{ip};
    
    for is = 1:nSolvers
        solver = cell_solvers{is};
        solver_official = cell_solvers_official{is};
        gradient = cell_gradient{is};
        filename = ['res_' problem '/test_' problem '_' solver '_' num2str(maxFunEvals) '_' num2str(nStarts) gradient '.mat'];
        if exist(filename, 'file')
            load(filename);
            nllh(ip,is,:) = -parameters_res.MS.logPost';
            funEvals(ip,is,:) = parameters_res.MS.n_objfun;
            if isfield(parameters_res,'time_ss')
                time_ss = parameters_res.time_ss;
            else
                time_ss = 0;
            end
            time(ip,is,:) = parameters_res.MS.t_cpu;
            time_ss(ip,is) = time_ss;
            bestFoundFval(ip) = min([-parameters_res.MS.logPost(:);bestFoundFval(ip)]);
        end
    end
    
    % waterfall plot
    fig = figure('name',['waterfall-' problem]);
    for is = 1:nSolvers
        tmp_y(:) = nllh(ip,is,:);
        
        semilogy(1:nStarts,tmp_y'-bestFoundFval(ip)+1,[markers{is} '-'],'DisplayName', cell_solvers_official{is}, 'color', colors(is,:), 'MarkerSize',3);
        hold on;
    end
    hold off;
    legend(legendon,'Location','northeastoutside');
    xlabel('ordered multi-starts');
    ylabel('negative log-likelihood (\rightarrow min)');
%     pbaspect([1 1 1]);
    xlim([1,100]);
    set(gcf,'units','centimeters','position',[0,0,2/3*fig_width,2/3*fig_height]);
    saveas(fig, [pwd '/images/waterfall-' problem], fileformat);
end

% further analysis
convergedStarts = zeros(nProblems,nSolvers);
funEvalsPerConvergedStart = inf(nProblems,nSolvers);
timePerConvergedStart = inf(nProblems,nSolvers);
convergedStartsPerTime = zeros(nProblems,nSolvers);
for ip = 1:nProblems
     for is = 1:nSolvers
         tmp_totalFunEvals = nansum(funEvals(ip,is,:));
         tmp_totalTime = nansum(time(ip,is,:)) + time_ss(ip,is);
         tmp_convergedStarts = sum(nllh(ip,is,:) < bestFoundFval(ip) + threshold);
         convergedStarts(ip,is) = tmp_convergedStarts / nStarts;
         funEvalsPerConvergedStart(ip,is) = tmp_totalFunEvals / tmp_convergedStarts; % / (cell_nPar{ip}*cell_maxFunEvals{ip});
         timePerConvergedStart(ip,is) = tmp_totalTime / tmp_convergedStarts;
         convergedStartsPerTime(ip,is) = tmp_convergedStarts / tmp_totalTime;
     end
end

% convergedstarts
fig = figure('name','convergedstarts');
for is = 1:nSolvers
    tmp_y = convergedStarts(:,is);
    plot(1:nProblems,100*tmp_y,[markers{is}],'DisplayName', cell_solvers_official{is}, 'color', colors(is,:));
    hold on;
end
hold off;
xticklabels(cell_problems_official);
xlabel('problem');
ylabel('converged runs [%]');
ylim([0,100]);
legend(legendon,'Location','northeastoutside');
% pbaspect([1 1 1]);
set(gcf,'units','centimeters','position',[0,0,fig_width,fig_height]);
saveas(fig, [pwd '/images/convergedstarts'], fileformat);

% timeperconvergedstart
fig = figure('name','timeperconvergedstart');
for is = 1:nSolvers
    tmp_y = timePerConvergedStart(:,is);
    semilogy(1:nProblems,tmp_y,[markers{is}],'DisplayName', cell_solvers_official{is},  'color', colors(is,:));
    hold on;
end
hold off;
xticklabels(cell_problems_official);
xlabel('problem');
ylabel('time / converged runs [s]');
legend(legendon,'Location','northeastoutside');
% pbaspect([1 1 1]);
set(gcf,'units','centimeters','position',[0,0,fig_width,fig_height]);
saveas(fig, [pwd '/images/timeperconvergedstart'], fileformat);

% funevalsperconvergedstart
fig = figure('name','funevalsperconvergedstart');
for is = 1:nSolvers
    tmp_y = funEvalsPerConvergedStart(:,is);
    semilogy(1:nProblems,tmp_y,[markers{is}],'DisplayName', cell_solvers_official{is},  'color', colors(is,:));
    hold on;
end
hold off;
xticklabels(cell_problems_official);
xlabel('problem');
ylabel('function evaluations / converged starts');
legend(legendon,'Location','northeastoutside');
% pbaspect([1 1 1]);
set(gcf,'units','centimeters','position',[0,0,fig_width,fig_height]);
saveas(fig, [pwd '/images/funevalsperconvergedstart'], fileformat);

% barplot

subplot = @(m,n,p) subtightplot (m, n, p, [0.1 0.1], [0.1 0.1], [0.1 0.1]);
% previously: m, n, p, [0.03 0.03], [0.1 0.1], [0.1 0.1]

fig = figure('name','collection');

ax = subplot(2,2,[1 2]);
ybar = bar(100*convergedStarts);
for is=1:nSolvers
    ybar(is).FaceColor = colors(is,:);
end
ylabel('converged runs [%]');
ylim([0,100]);
yticks([0 25 50 75 100]);
ax.XTickLabel = {'','','','','','','',''};
ax.TickLength = [ticklength/5 0.025];
ax.YGrid = ygrid;
legend(legendon,'Location','northeastoutside');
% set(gcf,'units','centimeters','position',[0,0,fig_width,fig_height]);

ax = subplot(2,2,[3,4]);
ybar = bar(convergedStartsPerTime);
for is=1:nSolvers
    ybar(is).FaceColor = colors(is,:);
end
set(gca,'yscale','log');
xticklabels(cell_problems_official);
% set(ax(1),'TickLength',[0,0]);
xlabel('problem');
ylabel('converged runs / time [1/s]');
ylim([0,100]);
ax.TickLength = [ticklength/5 0.025];
ax.YGrid = ygrid;
ax.MinorGridLineStyle = '-';
legend(legendon,'Location','northeastoutside');
set(gcf,'units','centimeters','position',[0,0,2*fig_width,0.9*fig_height]);
saveas(fig, [pwd '/images/collection'], fileformat);

clear subplot;

% horizontal barplot

fig = figure('name','collectionh');

subplot(2,2,[1 3]);
ybar = barh(100*convergedStarts(end:-1:1,end:-1:1));
hold on;
for is=1:nSolvers
    ybar(is).FaceColor = colors(end+1-is,:);
end
yticklabels(cell_problems_official(end:-1:1));
ylabel('problem');
xlabel('converged runs [%]');
xlim([0,100]);
for ip = 1:(nProblems-1)
    plot([0,100],[ip+0.5,ip+0.5],'--k');
end
legend(legendon,'Location','northeastoutside');
set(gcf,'units','centimeters','position',[0,0,fig_width,fig_height]);

subplot(2,2,[2 4]);
ybar = barh(100*convergedStartsPerTime(end:-1:1,end:-1:1));
hold on;
for is=1:nSolvers
    ybar(is).FaceColor = colors(end+1-is,:);
end
set(gca,'YTick',[]);
xlabel('converged runs / time [s^{-1}]');
for ip = 1:(nProblems-1)
    plot([0:0.0001:1e2],ip+0.5*ones(size(0:0.0001:1e2)),'--k');
end
xlim([0, 1e2]);
set(gca,'xscale','log');
legend(legendon,'Location','northeastoutside');
set(gcf,'units','centimeters','position',[0,0,1.3*fig_width,2*fig_height]);
saveas(fig, [pwd '/images/collectionh'], fileformat);

% bar(convergedStarts);

% for ip = 1:nProblems
%     
% end
% fig = figure('name',['convergedstarts-' problem]);
% mat_convergedStarts = zeros(nKeys,1);
% for j=1:nKeys
%     sol = map(cell_keys{j});
%     totalFunEvals = sum(sol.funEvals);
%     convergedStarts = sum(sol.logPost > bestFoundFval - 0.01);
%     mat_convergedstarts(j) = convergedStarts / 100;
% end
% bar(mat_convergedstarts);
% hold off;

% legend

figHandle = figure('name','legend');
hold on;
for j = 1:nSolvers
   plot([1,2],[nan,nan],[markers{j} '-'], 'DisplayName', cell_solvers_official{j}, 'color', colors(j,:));
end
[legHandle,legIcons] = legend('show');
legend boxoff;
legH = findobj(legIcons, 'type', 'line');
set(legH, 'LineWidth', 2*0.5);
set(gcf,'units','centimeters','position',[0,0,fig_width,fig_height]);
% sorry legend eps file has to be generated manually (via plot browser)
% saveLegendToImage(figHandle,legHandle,'images/legend','epsc');

function saveLegendToImage(figHandle, legHandle, ...
fileName, fileType)

%make all contents in figure invisible
allLineHandles = findall(figHandle, 'type', 'line');

for i = 1:length(allLineHandles)

    allLineHandles(i).XData = NaN; %ignore warnings

end

%make axes invisible
axis off

%move legend to lower left corner of figure window
legHandle.Units = 'pixels';
boxLineWidth = legHandle.LineWidth;
%save isn't accurate and would swallow part of the box without factors
legHandle.Position = [6 * boxLineWidth, 6 * boxLineWidth, ...
    legHandle.Position(3), legHandle.Position(4)];
legLocPixels = legHandle.Position;

%make figure window fit legend
figHandle.Units = 'pixels';
figHandle.InnerPosition = [1, 1, legLocPixels(3) + 12 * boxLineWidth, ...
    legLocPixels(4) + 12 * boxLineWidth];

%save legend
saveas(figHandle, fileName, fileType);

end