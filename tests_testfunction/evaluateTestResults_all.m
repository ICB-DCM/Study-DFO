clear all;
close all;

set_sizes = true;
fig_width = 1.5*8.4;
fig_height = fig_width;

evaluateTestResults;
evaluateTestResults_multistart;
evaluateTestResults_noise;

fig = figure('name','collection');

subplot(4,2,[1 2]);
ybar = bar(100*v_y_smooth_convex');
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
set(gca,'XTick',[]);
ylim([0,100]);
yticks([0 25 50 75 100]);
title('Multistart setting','Interpreter','latex');
% pbaspect([4 1 1]);

subplot(4,2,[3 4]);
ybar = bar(100*v_y_smooth_convex_all');
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
set(gca,'XTick',[]);
ylim([0,100]);
yticks([0 25 50 75 100]);
title('Singlestart setting','Interpreter','latex');
% pbaspect([4 1 1]);

subplot(4,2,[5 6]);
ybar = bar(100*v_y_smooth_convex_multistart');
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
set(gca,'XTick',[]);
ylim([0,100]);
yticks([0 25 50 75 100]);
title('Multistart setting, $$m_g = 40000, n_g = 1$$','Interpreter','latex');
% pbaspect([4 1 1]);

subplot(4,2,[7 8]);
ybar = bar(100*v_y_smooth_convex_noise');
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
xticklabels({'all','smooth','nonsmooth','convex','nonconvex'});
ylim([0,100]);
yticks([0 25 50 75 100]);
title('Multistart setting, noisy','Interpreter','latex');
% pbaspect([4 1 1]);
if set_sizes, set(gcf,'units','centimeters','position',[0,0,2*fig_width,0.8*fig_height]); end

saveas(fig, [pwd '/images/collection.png']);