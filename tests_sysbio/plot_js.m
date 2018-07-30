clear;
close all;

load res_js/test_js_dhc_1000_100.mat
pam_dhc = parameters_res;
load res_js/test_js_fmincon_1000_100_gradient.mat
pam_fmincon_gradient = parameters_res;

addpath(genpath('../models_sysbio/jakstat_small/'));

load data_jakstat.mat

objfun = @(x) llh_jakstat_standard(x, D);

t_max = max(D.t);
t_min = min(D.t);
visual_t = linspace(t_min,t_max,100);

amiOptions = amioption;
amiOptions.rtol = 1e-10;
amiOptions.atol = 1e-10;
amiOptions.sensi_meth = 'forward';

sim_dhc = simulate_jakstat_standard(visual_t,pam_dhc.MS.par(:,1),D.k,[],amiOptions);
sim_fmincon_gradient = simulate_jakstat_standard(visual_t,pam_fmincon_gradient.MS.par(:,1),D.k,[],amiOptions);

for j=1:3
    figure;
    hold on;
    plot(visual_t,sim_dhc.y(:,j),'x-b','DisplayName','DHC');
    plot(visual_t,sim_fmincon_gradient.y(:,j),'+-r','DisplayName','FMINCON');
    plot(D.t,D.Y(:,j,:),'ok','DisplayName','data');    
    legend('show','Location','northeastoutside');
end

% states
figure;
hold on;
plot(pam_dhc.MS.par(:,1),'x-b','DisplayName','DHC');
plot(pam_fmincon_gradient.MS.par(:,1),'+-r','DisplayName','FMINCON');
legend('show','Location','northeastoutside');

sim_dhc.llh
sim_fmincon_gradient.llh
