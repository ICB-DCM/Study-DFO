%% compile

if ~exist('hopfbifurcation','file')
    amiwrap('hopfbifurcation','hopfbifurcation_syms');
end

%% parameters

sigma = [0.075; 0.032; 0.046];
p  = [3.8;1;  1;  1;  1;  1;  1;  1;  sigma];
lb = [1;  0.8;0.8;0.8;0.8;0;  0;  0;  1e-2;  1e-2;  1e-2];
ub = [5;  1.2;1.2;1.2;1.2;2;  2;  2;  2;     2;     2];

t  = 0:2:200;

nt = length(t);
ny = 3;
nr = 1;

%% true solution
amiOptions = amioption;
amiOptions.sensi_meth = 'forward';
amiOptions.sensi = 0;
% amiOptions.atol = 1e-8;
% amiOptions.rtol = 1e-6;
% amiOptions.maxsteps = 1e5;
sol = simulate_hopfbifurcation(t,p,[],[],[],amiOptions);
% true observables
ytrue = sol.y; % nt * ny

%% create data for model ODE_M4

D = struct();
D.t = t;
D.k = [];
D.Y = zeros(nt,ny,nr);

for jt = 1:nt
    for jr = 1:nr
        D.Y(jt,:,jr) = ytrue(jt,:) + normrnd(0,sigma');
    end
end

sol_with_data = simulate_hopfbifurcation(t,p,[],D,amiOptions);

% save everything to file
save('data_hopfbifurcation.mat');