classdef Exercise
    %Exercise optimization data
    
    properties
        % function data
        name
        fun
        dim
        lb
        ub
        fbst
        xbst
        smooth
        convex
        unimodal
        
        % algorithm data
        alg
        x0
        maxFunEvals
    end
    
    methods
        function obj = Exercise(name,fun,dim,lb,ub,fbst,xbst,smooth,unimodal,alg,x0,maxFunEvals)
            obj.name = name;
            obj.fun = fun;
            obj.dim = dim;
            obj.lb = lb;
            obj.ub = ub;
            obj.fbst = fbst;
            obj.xbst = xbst;
            obj.smooth = smooth;
            obj.unimodal = unimodal;
            
            obj.alg = alg;
            obj.x0 = x0;
            obj.maxFunEvals = maxFunEvals;
        end
    end
    
end

