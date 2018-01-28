function [ result ] = doExercise( ex )
%RUNEXERCISE runs exercise

    fval_trace = zeros(2500,1);
    objfun = @(x) testFunctionWrapper(ex.fun,x);
    
    switch (ex.alg)
        case 'fmincon'
            options.MaxFunctionEvaluations = ex.maxFunEvals;
            options.MaxIterations = ex.maxFunEvals + 1;
%             options.StepTolerance = ex.tolX;
            options.Display = 'off';
            
            starttime = cputime;
            [x,fval,exitflag,output] = fmincon(objfun,ex.x0,[],[],[],[],ex.lb,ex.ub,[],options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.iterations,output.funcCount,cputime-starttime,exitflag,fval_trace);
        
        case 'fminsearchbnd'
            addpath('../algorithms/fminsearchbnd');
            
            % fminsearch does not take bounds
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIter = ex.maxFunEvals + 1;
%             options.TolX = ex.tolX;
%             options.TolFun = ex.tolFun;
            options.Display = 'off';
            
            starttime = cputime;
            [x,fval,exitflag,output] = fminsearchbnd(objfun,ex.x0,ex.lb,ex.ub,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.iterations,output.funcCount,cputime-starttime,exitflag,fval_trace);
          
        case 'direct'
            addpath('../algorithms/direct');
            
            Problem.f = objfun;
            
            bounds = zeros(ex.dim,2);
            bounds(:,1) = ex.lb(:);
            bounds(:,2) = ex.ub(:);
            
            options.maxevals = ex.maxFunEvals;
            options.maxits   = ex.maxFunEvals + 1;
            
            starttime = cputime;
            [x,fval,history] = direct(Problem,bounds,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,history(end,1),history(end,2),cputime-starttime,exitflag,fval_trace);
          
        case 'cmaes'
            addpath('../algorithms/cmaes');
            addpath('../algorithms');
            
            fitfun = 'functionHandleFileNameWrapper';
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIter = ex.maxFunEvals + 1;
%             options.TolX = ex.tolX;
%             options.TolFun = ex.tolFun;
            options.LBounds = ex.lb;
            options.UBounds = ex.ub;
            
            starttime = cputime;
            [x,fval,counteval,exitflag,~,~] = cmaes(fitfun,ex.x0,[],options,objfun);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,-1,counteval,cputime-starttime,exitflag,fval_trace);
            
        case {'meigo-ess-fmincon',...
              'meigo-ess-nomadm',...
              'meigo-ess-dhc-old',...
              'meigo-ess-dhc',...
              'meigo-ess-bobyqa'}
            addpath('../algorithms');
            addpath(genpath('../algorithms/MEIGO_M'));
          
            problem.f = 'functionHandleWrap';
            problem.x_L = ex.lb;
            problem.x_U = ex.ub;
%             problem.x_0 = ex.x0;
            
            options.inter_save = false;
            options.maxeval = ex.maxFunEvals;
            options.maxtime = Inf;
            
            switch (ex.alg)
                case 'meigo-ess-fmincon'
                    solver = 'fmincon';
                case 'meigo-ess-nomadm'
                    solver = 'nomad';
                case 'meigo-ess-dhc-old'
                    solver = 'dhc_old';
                case 'meigo-ess-dhc'
                    solver = 'dhc';
                case 'meigo-ess-bobyqa'
                    solver = 'bobyqa';
            end
            options.local.solver = solver;
            options.local.finish = solver;
            
            options.local.iterprint = 0; % no output after each iteration
            options.iterprint = 0;
            options.plot = 0;
            %options.local.tol = 3; % does not take tolerance really
            
            starttime = cputime;
            ret = MEIGO(problem,options,'ESS',objfun);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                ret.fbest,ret.xbest,-1,ret.numeval,cputime-starttime,ret.end_crit,fval_trace);
          
        case 'rcs'
            addpath('../algorithms/rcs');
            
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIter = ex.maxFunEvals + 1;
%             options.TolX = ex.tolX;
%             options.TolFun = ex.tolFun;
            
            starttime = cputime;
            [x,fval,exitflag,output] = rcs(objfun,ex.x0,ex.lb,ex.ub,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.iterations,output.funcCount,cputime-starttime,exitflag,fval_trace);
            
        case 'dhc'
            addpath('../algorithms/dhc');
            
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIter = ex.maxFunEvals + 1;
%             options.TolX = ex.tolX;
%             options.TolFun = ex.tolFun;
                 
            starttime = cputime;
            [x,fval,exitflag,output] = dhc(objfun,ex.x0,ex.lb,ex.ub,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.iterations,output.funcCount,cputime-starttime,exitflag,fval_trace);
         
        case 'bobyqa'
            addpath('../algorithms/bobyqa');
            
            options.MaxFunEvals = ex.maxFunEvals;
%             options.Rhoend = ex.tolX;
            
            starttime = cputime;
            [x,fval,exitflag,output] = bobyqa(objfun,ex.x0,ex.lb,ex.ub,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.funcCount,output.funcCount,cputime-starttime,exitflag,fval_trace);
            
        case 'mcs'
            
        case 'nomadm'
            
        case 'pswarm'
            
        case 'snobfit'
            
        case 'imfil'
            
        case 'ga'
            
        case 'gps'
            
        case 'gss'
            
        case 'mads'
            
        case 'simulannealbnd'
            
        case 'particleswarm'
            
        otherwise
            error('Could not identify optimizer');
    end

end