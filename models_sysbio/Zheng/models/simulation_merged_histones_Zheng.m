function varargout = simulation_merged_histones_Zheng(t,xi,options)

% if strcmp(options.llh.approach,'standard')
%     xi = xi(1:end-5);
% end
xdot = Inf;
t_max = 2e4;
while abs(max(xdot)) > 10^(-8) || sum(sol_pre.x) < 1 - 1e-8 % check if system is in steady state
    sol_pre = simulate_histones_preequ_Zheng(t_max,xi,[],[],options.ami);
    xdot = sol_pre.xdot;
    t_max = t_max+2e4;
    if t_max >= 1e6
        error('steady state not reached, t_max=1e6');
    end
end
if sol_pre.status == 0
    if options.ami.sensi
        options.ami.sx0 = squeeze(sol_pre.sx);
    end
    sol = simulate_histones_Zheng(t,xi,sol_pre.x,[],options.ami);
else
    error('simulation failed')
end
varargout{1}=sol;
if nargout > 1
   varargout{2} = sol_pre;
end
end