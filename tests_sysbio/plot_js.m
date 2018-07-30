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

sim_dhc = simulate_jakstat_standard(visual_t,pam_dhc.MS.par(:,1),[],D,amiOptions);
sim_fmincon_gradient = simulate_hopfbifurcation(visual_t,pam_fmincon_gradient.MS.par(:,1),[],D,amiOptions);

for j=1:2
    figure;
    hold on;
    plot(sim_dhc.y(:,j),'g','DisplayName','DHC');
    plot(sim_fmincon_gradient.y(:,j),'m','DisplayName','FMINCON');
    plot(sim_pswarm.y(:,j),'c','DisplayName','PSWARM');
    plot(D.Y(:,j,:),'.b','DisplayName','data');
    
    plot(sim_true.y(:,j),'r:','DisplayName','true trajectory');
    
    legend('show','Location','northeastoutside');
end

% states
figure;
hold on;
plot(pam_dhc.MS.par(:,1),'g','DisplayName','DHC');
plot(pam_fmincon_gradient.MS.par(:,1),'m','DisplayName','FMINCON');
plot(pam_pswarm.MS.par(:,1),'c','DisplayName','PSWARM');
plot(p,'DisplayName','orig. pam');
legend('show','Location','northeastoutside');

sim_true.llh
sim_dhc.llh
sim_pswarm.llh
sim_fmincon_gradient.llh
