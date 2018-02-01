%% compilation Histones Zheng

% preequilibration model
[exdir,~,~]=fileparts(which('histones_preequ_Zheng_syms.m'));
amiwrap('histones_preequ_Zheng','histones_preequ_Zheng_syms',exdir)

% main model
[exdir,~,~]=fileparts(which('histones_Zheng_syms.m'));
amiwrap('histones_Zheng','histones_Zheng_syms',exdir)
