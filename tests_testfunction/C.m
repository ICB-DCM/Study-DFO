classdef C
    %C Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        nStarts_local      = 25;
        nStarts_global     = 1;
        
        arr_dims        = [2,3,4,5,10,15,20,25,30,35,40,50,75,100,200,300];
        nDims           = length(C.arr_dims);
        
        tolX            = 1e-10;
        tolFun          = 1e-10;
        
        maxFunEvals_local  = 2000;
        maxFunEvals_global = 50000;
        
        cell_solvers_local         = {'fmincon','fminsearchbnd','rcs','ydhc'};
        nSolvers_local             = length(C.cell_solvers_local);
        cell_solvers_global        = {'cmaes','meigo-ess-fmincon','meigo-ess-dhc','meigo-ess-ydhc'};
        nSolvers_global            = length(C.cell_solvers_global);
        
        fval_tolerance  = 1e-3;
        
    end
    
    methods
    end
    
end

