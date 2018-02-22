clear all;
close all;

set_sizes = true;
fig_width = 1.4*8.4;
fig_height = fig_width;
fileformat = 'epsc';

solvers_for_output = {'FMINCON','BOBYQA','DHC','DHC-OLD','FMINSEARCHBND','IMFIL','PATTERNSEARCH-GPS','PATTERNSEARCH-MADS','RCS','SIMULANNEALBND',...
    'DIRECT','MCS','CMAES','GA','PARTICLESWARM','PSWARM','MEIGO-ESS-BOBYQA','MEIGO-ESS-DHC-OLD','MEIGO-ESS-DHC','MEIGO-ESS-FMINCON'};

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
plot([1.5 1.5], [0,100], '-k');
plot([3.5 3.5], [0,100], '-k');
title('1: Multistart setting','Interpreter','latex');
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
plot([1.5 1.5], [0,100], '-k');
plot([3.5 3.5], [0,100], '-k');
title('2: Singlestart setting','Interpreter','latex');
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
plot([1.5 1.5], [0,100], '-k');
plot([3.5 3.5], [0,100], '-k');
title('3: Multistart setting, $$m_g = 40000, n_g = 1$$','Interpreter','latex');
% pbaspect([4 1 1]);

subplot(4,2,[7 8]);
ybar = bar(100*v_y_smooth_convex_noise');
hold on;
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
xticklabels({'all','smooth','non-smooth','convex','non-convex'});
ylim([0,100]);
yticks([0 25 50 75 100]);
plot([1.5 1.5], [0,100], '-k');
plot([3.5 3.5], [0,100], '-k');
title('4: Multistart setting, noisy','Interpreter','latex');
% pbaspect([4 1 1]);
if set_sizes, set(gcf,'units','centimeters','position',[0,0,2.5*fig_width,fig_height]); end

suplabel('function category','x');
suplabel('solved problems [%]','y');

saveas(fig, [pwd '/images/collection'], 'epsc');