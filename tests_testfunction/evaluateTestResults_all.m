clear all;
close all;

set_sizes = true;
fig_width = 8.4;
fig_height = fig_width;
fileformat = 'epsc';

solvers_from_input = {'FMINCON','BOBYQA','DHC','DHC-OLD','FMINSEARCHBND','IMFIL','PATTERNSEARCH-GPS','PATTERNSEARCH-MADS','RCS','SIMULANNEALBND',...
    'DIRECT','MCS','CMAES','GA','PARTICLESWARM','PSWARM','MEIGO-ESS-BOBYQA','MEIGO-ESS-DHC','MEIGO-ESS-DHC-OLD'};
solvers_for_output = solvers_from_input;
% renaming: all in the data generation pipeline, we used 'dhc-old' to
% denote the previoulsy implemented version of dhc in meigo, but it will be
% displayed as 'meigo-dhc'.
solvers_for_output{4} = 'MEIGO-DHC';
solvers_for_output{19} = 'MEIGO-ESS-MEIGO-DHC';

% legend

nKeys = length(solvers_for_output);

colors = distinguishable_colors(nKeys);
markers = {'o','+','*','.','x','s','d','^','v','<','>','p','h','o','+','*','.','x','s','d','^','v','<','>','p','h','o','+','*','.','x','s','d','^','v','<','>','p','h'};
markers = markers(1:nKeys);
axes('NextPlot','replacechildren', 'ColorOrder',colors); 

figHandle = figure('name','legend');
hold on;
for j = 1:nKeys
   plot([1,2],[1,2],[markers{j} '-'], 'DisplayName', solvers_for_output{j}, 'color', colors(j,:));
end
legHandle = legend('show');
legend boxoff;
saveLegendToImage(figHandle,legHandle,'images/legend','epsc');


evaluateTestResults;
evaluateTestResults_multistart;
evaluateTestResults_noise;

fig = figure('name','collection');

subplot(4,2,[1 2]);
ybar = bar(100*v_y_smooth_convex');
hold on;
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
set(gca,'XTick',[]);
ylim([0,100]);
yticks([0 25 50 75 100]);
plot([1.5 1.5], [0,100], '--k');
plot([3.5 3.5], [0,100], '--k');
title('A1: Multi-start setting','Interpreter','latex');
% pbaspect([4 1 1]);

subplot(4,2,[3 4]);
ybar = bar(100*v_y_smooth_convex_all');
hold on;
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
set(gca,'XTick',[]);
ylim([0,100]);
yticks([0 25 50 75 100]);
plot([1.5 1.5], [0,100], '--k');
plot([3.5 3.5], [0,100], '--k');
title('A2: Single-start setting','Interpreter','latex');
% pbaspect([4 1 1]);

subplot(4,2,[5 6]);
ybar = bar(100*v_y_smooth_convex_multistart');
hold on;
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
set(gca,'XTick',[]);
ylim([0,100]);
yticks([0 25 50 75 100]);
plot([1.5 1.5], [0,100], '--k');
plot([3.5 3.5], [0,100], '--k');
title('A3: Multi-start setting, $$m_g = 40000, k_g = 1$$','Interpreter','latex');
% pbaspect([4 1 1]);

ax = subplot(4,2,[7 8]);
ybar = bar(100*v_y_smooth_convex_noise');
hold on;
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
xticklabels({'all','smooth','non-smooth','convex','non-convex'});
ylim([0,100]);
yticks([0 25 50 75 100]);
plot([1.5 1.5], [0,100], '--k');
plot([3.5 3.5], [0,100], '--k');
set(ax(1),'TickLength',[0,0]);
title('A4: Multi-start setting, noisy','Interpreter','latex');
% pbaspect([4 1 1]);
mult_factor = 2;
if set_sizes, set(gcf,'units','centimeters','position',[0,0,2*mult_factor*fig_width,mult_factor*fig_height]); end

suplabel('solved problems [%]','y');

saveas(fig, [pwd '/images/collection'], 'epsc');

disp('done evaluateTestResults');






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