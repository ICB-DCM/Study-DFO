load('testMeigo_jakstat.mat');

figure;
hold on;

plot(parameters_fmincon.MS.logPost,'DisplayName','fmincon');
plot(parameters_dhc.MS.logPost,'DisplayName','dhc');
plot(parameters_ydhc.MS.logPost,'DisplayName','ydhc');

xlabel('optimization run');
ylabel('maximum value (larger better)');
legend('show','Location','northeastoutside');
title('Parameter estimation for a JakStat model');
