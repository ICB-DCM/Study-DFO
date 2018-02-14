clear;
close all;

load res_hb/test_hb_dhc_500_100.mat
pam_dhc = parameters_res;
load res_hb/test_hb_fmincon_500_100_gradient.mat
pam_fmincon_gradient = parameters_res;
load res_hb/test_hb_pswarm_500_100.mat
pam_pswarm = parameters_res;

addpath('../models_sysbio/hopfbifurcation/');

load data_hopfbifurcation.mat

objfun = @(x) llh(x, D, @simulate_hopfbifurcation);

amiOptions = amioption;
amiOptions.sensi_meth = 'forward';
amiOptions.sensi = 0;

sim_true = simulate_hopfbifurcation(D.t,p,[],D,amiOptions);
sim_dhc = simulate_hopfbifurcation(D.t,pam_dhc.MS.par(:,1),[],D,amiOptions);
sim_pswarm = simulate_hopfbifurcation(D.t,pam_pswarm.MS.par(:,1),[],D,amiOptions);
sim_fmincon_gradient = simulate_hopfbifurcation(D.t,pam_fmincon_gradient.MS.par(:,1),[],D,amiOptions);

for j=1:3
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
