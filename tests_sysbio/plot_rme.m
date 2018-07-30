clear;
close all;

load res_rme/test_rme_dhc_1000_100.mat
pam_dhc = parameters_res;
load res_rme/test_rme_fmincon_1000_100_gradient.mat
pam_fmincon_gradient = parameters_res;

addpath(genpath('../models_sysbio/rafmekerk/'));

load data_rafmekerk_noreps.mat
Dstandard = D;
load data_rafmekerk.mat

objfun = @(x) llh_rafmekerk_standard(x, D);

t_max = max(Dstandard(1).t);
t_min = min(Dstandard(1).t);
visual_t = linspace(t_min,t_max,100);

amiOptions = amioption;
amiOptions.rtol = 1e-10;
amiOptions.atol = 1e-10;
amiOptions.sensi_meth = 'forward';

sim_dhc = simulate_rafmekerk_standard(visual_t,pam_dhc.MS.par(:,1),Dstandard(1).k,[],amiOptions);
sim_fmincon_gradient = simulate_rafmekerk_standard(visual_t,pam_fmincon_gradient.MS.par(:,1),Dstandard(1).k,[],amiOptions);

for j=1:2
    figure;
    hold on;
    plot(visual_t,sim_dhc.y(:,j),'x-b','DisplayName','DHC');
    plot(visual_t,sim_fmincon_gradient.y(:,j),'+-r','DisplayName','FMINCON');
    for je = 1:1
        for jr = 1:4
            plot(D(je).t,D(1).Y(:,j,jr),'ok','DisplayName','data');
        end
    end
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
