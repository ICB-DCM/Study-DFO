classdef C
    %C Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        nStarts_local      = 25;
        nStarts_global     = 1;
        
        arr_dims        = [2,3,4,5,10,15,20,25,30,35,40,50,75,100,200,300];
        nDims           = length(C.arr_dims);
        
%         tolX            = 1e-10;
%         tolFun          = 1e-10;
        
        maxFunEvals_local  = 2000;
        maxFunEvals_global = 50000;
        maxFunEvals = {2e3,2e4,2e5};
        
        maxTime = 60*10; % 10 minutes
        
        cell_solvers_local         = {'fmincon','fminsearchbnd','rcs',...
            'dhc','bobyqa','imfil',...
            'gps','gss','mads',...
            'simulannealbnd'};
        nSolvers_local             = length(C.cell_solvers_local);
        cell_solvers_global        = {'direct','cmaes','meigo-ess-fmincon',...
            'meigo-ess-dhc-old','meigo-ess-dhc','meigo-ess-bobyqa',...
            'mcs','pswarm','snobfit',...
            'ga','particleswarm'};
        nSolvers_global            = length(C.cell_solvers_global);
        
        fval_tolerance  = 1e-2;
        
    end
    
    methods (Static)
        function solver_type = is_local_or_global(solver)
            if any(ismember(C.cell_solvers_local,solver))
                solver_type = 'local';
            elseif any(ismember(C.cell_solvers_global,solver))
                solver_type = 'global';
            else
                solver_type = 'unknown';
            end
        end
    end
    
end

