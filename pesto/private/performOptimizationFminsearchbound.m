function [outputArg1,outputArg2] = performOptimizationFminsearchbound(parameters, negLogPost, iMS, par0, J_0, options)

    x0 = par0(:,iMS);
    lb = parameters.min;
    ub = parameters.max;

    [theta,J_opt,exitflag,output] = fminsearchbound(negLogPost,x0,lb,ub,options.localOptimizerOptions);
    
    % Assignment of results
    parameters.MS.exitflag(iMS)     = exitflag;
    parameters.MS.logPost0(1,iMS)   = -J_0;
    parameters.MS.logPost(iMS)      = -J_opt;
    parameters.MS.par(freePars,iMS) = theta;
    parameters.MS.par(options.fixedParameters,iMS) = options.fixedParameterValues;
    
    % Assignment of gradient and Hessian
    try
        [~, G_opt, H_opt] = negLogPost(theta);
        parameters.MS.hessian(freePars,freePars,iMS) = H_opt;
        parameters.MS.hessian(options.fixedParameters,options.fixedParameters,iMS) = nan;
        parameters.MS.gradient(freePars,iMS) = G_opt;
        parameters.MS.gradient(options.fixedParameters,iMS) = nan;
    catch
        warning('Could not compute Hessian and gradient at optimum after optimization.');
        if (options.objOutNumber == 3)
            warning('options.objOutNumber set to 3, but your objective function can not provide 3 outputs. Please set objOutBuner accordingly!');
        end
    end
    % Assignment of diagnosis
    parameters.MS.n_objfun(iMS)  = output.funcCount;
    parameters.MS.n_iter(iMS)    = output.iterations;
    parameters.MS.t_cpu(iMS)     = output.t_cpu;
    
    % Assignment of AIC and BIC
    parameters.MS.AIC(iMS) = 2*length(freePars) + 2*J_opt;
    if ~isempty(options.nDatapoints)
        parameters.MS.BIC(iMS) = log(options.nDatapoints)*length(freePars) + 2*J_opt;
    end
end

