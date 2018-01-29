function [ result ] = doExercise( ex )
%RUNEXERCISE runs exercise

    fval_trace = zeros(2500,1);
    objfun = @(x) testFunctionWrapper(ex.fun,x);
    
    switch (ex.alg)
        case 'fmincon'
            % local
            
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
            % local
            
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
            % global
            
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
                fval,x,history(end,1),history(end,2),cputime-starttime,-1,fval_trace);
          
        case 'cmaes'
            % global
            
            addpath('../algorithms/cmaes');
            addpath('../algorithms');
            
            fitfun = 'funHandleFileNameWrap';
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
            % global
          
            addpath('../algorithms');
            addpath(genpath('../algorithms/MEIGO_M'));
          
            problem.f = 'funHandleFileNameWrap';
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
            % local
            
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
            % local
            
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
            % local
            
            addpath('../algorithms/bobyqa');
            
            options.MaxFunEvals = ex.maxFunEvals;
%             options.Rhoend = ex.tolX;
            
            starttime = cputime;
            [x,fval,exitflag,output] = bobyqa(objfun,ex.x0,ex.lb,ex.ub,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.funcCount,output.funcCount,cputime-starttime,exitflag,fval_trace);
            
        case 'mcs'
            % global
            
            addpath(genpath('../algorithms/mcs'));
            
            fcn = 'mcsFunHandleWrap';
            printLevel = 0; % no printing
            smax = 5*dim+10; % default number of levels
            
            starttime = cputime;
            [x,fval,~,~,ncall,~,flag] = mcs(fcn,objfun,ex.lb,ex.ub,printLevel,smax,ex.maxFunEvals);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,-1,ncall,cputime-starttime,flag,fval_trace);
            
        case 'nomadm'
            % local
            % integrated in matlab:patternsearch
            
            addpath('../algorithms/nomadm');
            
            error('Not implemented');
            
            
        case 'pswarm'
            % global
            
            addpath('../algorithms/PSwarmM_v2_1');
            
            problem = struct();
            problem.ObjFunction = 'funHandleFileNameWrap';
            problem.LB = ex.lb;
            problem.UB = ex.ub;
            
            initialPopulation = [];
            options.MaxObj = ex.maxFunEvals;
            
            starttime = cputime;
            [x,fval,runData] = PSwarm(problem,initialPopulation,options,objfun);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,runData.IterCounter,runData.ObjFunCounter,cputime-starttime,-1,fval_trace);
            
        case 'snobfit'
            % global
            
            addpath('../algorithms/snobfit_v2.1');
            addpath('../algorithms/mcs/minq8');
            
            options.MaxFunEvals = ex.maxFunEvals;
            
            starttime = cputime;
            [x,fval,exitflag,output] = ysnobfit(objfun,ex.lb,ex.ub,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.funcCount,output.funcCount,cputime-starttime,exitflag,fval_trace);
            
        case 'imfil'
            % local
            
            imfilfun = @(x,h) [objfun(x), 0, 1];
            bounds = [ex.lb, ex.ub];
            starttime = cputime;
            [x,histout] = imfil(ex.x0,imfilfun,ex.maxFunEvals,bounds);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                objfun(x),x,-1,size(histout,1),cputime-starttime,-1,fval_trace);
            
        case 'ga'
            % global
            
            if ex.dim <= 5
                options.MaxGenerations = ex.maxFunEvals / 50;
                options.PopulationSize = 50;
            else
                options.MaxGenerationa = ex.maxFunEvals / 200;
                options.PopulationSize = 200;
            end 
            options.Display = 'off';
            
            starttime = cputime;
            [x,fval,exitflag,output] = ga(objfun,ex.dim,[],[],[],[],ex.lb,ex.ub,[],[],options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.iterations,output.funccount,cputime-starttime,exitflag,fval_trace);
        
            
        case {'gps','gss','mads'}
            % local
            
            options.MaxFunctionEvaluations = ex.maxFunEvals;
            options.MaxIterations = ex.maxFunEvals + 1;
            options.Display = 'off';
            switch ex.alg
                case 'gps'
                    pollmethod = 'GPSPositiveBasis2N';
                case 'gss'
                    pollmethod = 'GSSPositiveBasis2N';
                case 'mads'
                    pollmethod = 'MADSPositiveBasis2N';
            end
            options.PollMethod = pollmethod;
            
            starttime = cputime;
            [x,fval,exitflag,output] = patternsearch(objfun,ex.x0,[],[],[],[],ex.lb,ex.ub,[],options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.iterations,output.funccount,cputime-starttime,exitflag,fval_trace);
        
        case 'simulannealbnd'
            % local
            
            options.MaxFunctionEvaluations = ex.maxFunEvals;
            options.MaxIterations = ex.maxFunEvals + 1;
            options.Display = 'off';
            
            starttime = cputime;
            [x,fval,exitflag,output] = simulannealbnd(fun,ex.x0,ex.lb,ex.ub,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.iterations,output.funccount,cputime-starttime,exitflag,fval_trace);
                    
        case 'particleswarm'
            % global
            
            options.MaxIterations = ex.maxFunEvals + 1; % no MaxFunctionEvaluations field
            options.Display = 'off';
            
            starttime = cputime;
            [x,fval,exitflag,output] = particleswarm(fun,ex.dim,ex.lb,ex.ub,options);
            result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                fval,x,output.iterations,output.funccount,cputime-starttime,exitflag,fval_trace);
        
        otherwise
            error('Could not identify optimizer');
    end

end