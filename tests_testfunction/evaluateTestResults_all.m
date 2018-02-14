clear all;
close all;

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
% pbaspect([4 1 1]);

subplot(4,2,[3 4]);
ybar = bar(100*v_y_smooth_convex_all');
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
set(gca,'XTick',[]);
ylim([0,100]);
% pbaspect([4 1 1]);

subplot(4,2,[5 6]);
ybar = bar(100*v_y_smooth_convex_multistart');
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
set(gca,'XTick',[]);
ylim([0,100]);
% pbaspect([4 1 1]);

subplot(4,2,[7 8]);
ybar = bar(100*v_y_noise');
for j=1:nKeys
    ybar(j).FaceColor = colors(j,:);
end
xticklabels({'all','smooth','nonsmooth','convex','nonconvex'});
ylim([0,100]);
% pbaspect([4 1 1]);

saveas(fig, [pwd '/images/collection.png']);