clear;
close all;

% cell_solvers_official = {'bobyqa','cmaes','dhc','direct','fmincon','fmincon+g','hybrid-mcs-fmincon+g','hybrid-simple-fmincon+g','hybrid-snobfit-fmincon+g','mcs','meigo-ess-fmincon','meigo-ess-fmincon+g','pswarm','rcs'};
cell_solvers_official = {'BOBYQA','CMAES','DHC','DIRECT','FMINCON','FMINCON+g','HYBRID-MCS-FMINCON+g','HYBRID-SIMPLE-FMINCON+g','HYBRID-SNOBFIT-FMINCON+g','MCS','MEIGO-ESS-FMINCON','MEIGO-ESS-FMINCON+g','PSWARM'};
% cell_solvers = {'bobyqa','cmaes','dhc','direct','fmincon','fmincon','hybrid-mcs','hybrid-simple','hybrid-snobfit','mcs','meigo-ess','meigo-ess','pswarm','rcs'};
cell_solvers = {'bobyqa','cmaes','dhc','direct','fmincon','fmincon','hybrid-mcs','hybrid-simple','hybrid-snobfit','mcs','meigo-ess','meigo-ess','pswarm'};
cell_gradient = {'','','','','','_gradient','','','','','','_gradient','',''};

cell_problems = {'cr','ec','hb','js','mt','pom','rme'};
cell_problems_official = {'CR','EC','HB','JS','MT','POM','RME'};
cell_maxFunEvals = {500,500,500,1000,500,500,1000};
cell_nStarts = {100,100,100,100,100,100,100};
cell_nPar = {2,4,11,17,5,7,28};

nSolvers = length(cell_solvers);
nProblems = length(cell_problems);
nStarts = 100;

colors = distinguishable_colors(nSolvers);
markers = {'o','+','*','.','x','s','d','^','v','<','>','p','h','o','+','*','.','x','s','d','^','v','<','>','p','h','o','+','*','.','x','s','d','^','v','<','>','p','h'};
markers = markers(1:nSolvers);
axes('NextPlot','replacechildren', 'ColorOrder',colors); 
legendon = 'off';

funEvals = zeros(nProblems,nSolvers,nStarts);
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
            bestFoundFval(ip) = min([-parameters_res.MS.logPost(:);bestFoundFval(ip)]);
        end
    end
    
    % waterfall plot
    fig = figure('name',['waterfall-' problem]);
    for is = 1:nSolvers
        tmp_y(:) = nllh(ip,is,:);
        
        semilogy(1:nStarts,tmp_y'-bestFoundFval(ip)+1,[markers{is} '-'],'DisplayName', cell_solvers_official{is});
        hold on;
    end
    hold off;
    legend(legendon,'Location','northeastoutside');
    xlabel('ordered multistarts');
    ylabel('negative log-likelihood');
    pbaspect([1 1 1]);
    saveas(fig, [pwd '/images/waterfall-' problem '.png']);
end

% converged starts
convergedStarts = zeros(nProblems,nSolvers);
funEvalsPerConvergedStart = inf(nProblems,nSolvers);
for ip = 1:nProblems
     for is = 1:nSolvers
         tmp_totalFunEvals = nansum(funEvals(ip,is,:));
         tmp_convergedStarts = sum(nllh(ip,is,:) < bestFoundFval(ip) + 0.5);
         convergedStarts(ip,is) = tmp_convergedStarts / nStarts;
         funEvalsPerConvergedStart(ip,is) = tmp_totalFunEvals / tmp_convergedStarts; % / (cell_nPar{ip}*cell_maxFunEvals{ip});
     end
end

fig = figure('name','convergedstarts');
for is = 1:nSolvers
    tmp_y = convergedStarts(:,is);
    plot(1:nProblems,100*tmp_y,[markers{is}],'DisplayName', cell_solvers_official{is});
    hold on;
end
hold off;
xticklabels(cell_problems_official);
xlabel('problem');
ylabel('converged starts [%]');
ylim([0,100]);
legend(legendon,'Location','northeastoutside');
pbaspect([1 1 1]);
saveas(fig, [pwd '/images/convergedstarts.png']);

fig = figure('name','funevalsperconvergedstart');
for is = 1:nSolvers
    tmp_y = funEvalsPerConvergedStart(:,is);
    semilogy(1:nProblems,tmp_y,[markers{is}],'DisplayName', cell_solvers_official{is});
    hold on;
end
hold off;
xticklabels(cell_problems_official);
legend(legendon,'Location','northeastoutside');
pbaspect([1 1 1]);
saveas(fig, [pwd '/images/funevalsperconvergedstart.png']);

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
   plot([1,2],[1,2],[markers{j} '-'], 'DisplayName', cell_solvers_official{j}, 'color', colors(j,:));
end
legHandle = legend('show');
saveLegendToImage(figHandle,legHandle,'images/legend','png');

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
saveas(figHandle, [fileName, '.', fileType], fileType);

end