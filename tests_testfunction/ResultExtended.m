classdef ResultExtended < Result
    
    properties
        % best value found among first maxFunEvals values
        accurate_fval
        % number of function evaluations
        accurate_funEvals
        % continually decreasing list of maxFunEvals values
        accurate_fval_trace
    end
    
    methods
        function obj = ResultExtended(result)
            obj@Result(result.name,result.dim,result.lb,result.ub,result.fbst,result.xbst,...
                result.smooth,result.convex,result.unimodal,result.alg,result.x0,result.maxFunEvals,...
                result.fval,result.x,result.iterations,result.funEvals,result.time,result.exitflag,result.fval_trace);
            
            % set accurate values
            obj.accurate_funEvals = min([obj.maxFunEvals length(obj.fval_trace)]);
            obj.accurate_fval_trace = nan(obj.maxFunEvals,1);
            obj.accurate_fval_trace(1) = obj.fval_trace(1);
            for j=2:obj.accurate_funEvals
                obj.accurate_fval_trace(j) = min([obj.accurate_fval_trace(j-1) obj.fval_trace(j)]);
            end
            for j=(obj.accurate_funEvals+1):obj.maxFunEvals
                obj.accurate_fval_trace(j) = obj.accurate_fval_trace(obj.accurate_funEvals);
            end
            obj.accurate_fval = obj.accurate_fval_trace(obj.maxFunEvals);
            obj.accurate_fval_trace = [];
            obj.fval_trace = []; % save space
        end
    end
end

