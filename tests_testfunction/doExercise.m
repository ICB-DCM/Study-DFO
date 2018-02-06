
function [ result ] = doExercise( ex )
%RUNEXERCISE runs exercise

% some global variables to hack into the function calls and protocol the
% important data
global y_arr_fval_trace; % keep track of fevals
y_arr_fval_trace = [];
global y_feval_counter; % count fevals
y_feval_counter = 0;
global y_fbst; % best fval so far
y_fbst = inf;
global y_xbst; % x value for best fval
y_xbst = [];
global y_flag_time; % indicate if ended bc time up
y_flag_time = 0;
global y_flag_fevals; % indicate if ended bc maxFunEvals reached
y_flag_fevals = 0;
starttic = tic; % for time measurement
objfun = @(x) testFunWrap(ex.fun,ex.maxFunEvals,starttic,x);

try
    
    switch (ex.alg)
        case 'fmincon'
            % local
            
            options.MaxFunctionEvaluations = ex.maxFunEvals;
            options.MaxIterations = ex.maxFunEvals + 1;
            %             options.StepTolerance = ex.tolX;
            options.Display = 'off';
            
            fmincon(objfun,ex.x0,[],[],[],[],ex.lb,ex.ub,[],options);
            
        case 'fminsearchbnd'
            % local
            
            addpath('../algorithms/fminsearchbnd');
            
            % fminsearch does not take bounds
            options = optimset();
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIter = ex.maxFunEvals + 1;
            %             options.TolX = ex.tolX;
            %             options.TolFun = ex.tolFun;
            options.Display = 'off';
            
            fminsearchbnd(objfun,ex.x0,ex.lb,ex.ub,options);
            
        case 'direct'
            % global
            
            addpath('../algorithms/direct');
            
            Problem.f = objfun;
            
            bounds = zeros(ex.dim,2);
            bounds(:,1) = ex.lb(:);
            bounds(:,2) = ex.ub(:);
            
            options.maxevals = ex.maxFunEvals;
            options.maxits   = ex.maxFunEvals + 1;
            
            direct(Problem,bounds,options);
            
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
            
            cmaes(fitfun,ex.x0,[],options,objfun);
            
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
            
            MEIGO(problem,options,'ESS',objfun);
            
        case 'rcs'
            % local
            
            addpath('../algorithms/rcs');
            
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIter = ex.maxFunEvals + 1;
            %             options.TolX = ex.tolX;
            %             options.TolFun = ex.tolFun;
            
            rcs(objfun,ex.x0,ex.lb,ex.ub,options);
            
        case 'dhc'
            % local
            
            addpath('../algorithms/dhc');
            
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIter = ex.maxFunEvals + 1;
            %             options.TolX = ex.tolX;
            %             options.TolFun = ex.tolFun;
            
            dhc(objfun,ex.x0,ex.lb,ex.ub,options);
            
        case 'bobyqa'
            % local
            
            addpath('../algorithms/bobyqa');
            
            options.MaxFunEvals = ex.maxFunEvals;
            %             options.Rhoend = ex.tolX;
            
            bobyqa(objfun,ex.x0,ex.lb,ex.ub,options);
            
        case 'mcs'
            % global
            
            addpath(genpath('../algorithms/mcs'));
            
            fcn = 'mcsFunHandleWrap';
            printLevel = 0; % no printing
            smax = 5*ex.dim+10; % default number of levels
            maxFunEvals = ex.maxFunEvals; % C.maxFunEvals_local;
            
            mcs(fcn,objfun,ex.lb,ex.ub,printLevel,smax,maxFunEvals);
            
        case 'nomadm'
            % local
            % integrated in matlab:patternsearch
            
            addpath('../algorithms/nomadm');
            
            error('Not implemented');
            
            
        case 'pswarm'
            % global
            
            addpath('../algorithms/PSwarmM_v2_1');
            addpath('../algorithms');
            
            problem = struct();
            problem.ObjFunction = 'funHandleFileNameWrap';
            problem.LB = ex.lb;
            problem.UB = ex.ub;
            
            initialPopulation = [];
            options.MaxIter = ex.maxFunEvals + 1;
            options.MaxObj = ex.maxFunEvals;
            
            PSwarm(problem,initialPopulation,options,objfun);
            
        case 'snobfit'
            % global
            
            addpath('../algorithms/snobfit_v2.1');
            addpath('../algorithms/mcs/minq8');
            
            options.MaxFunEvals = ex.maxFunEvals; % C.maxFunEvals_local;
            
            ysnobfit(objfun,ex.lb,ex.ub,options);
            
        case 'imfil'
            % local
            
            addpath('../algorithms/imfil');
            
            imfilfun = @(x) yimfilfun(objfun,x);
            bounds = [ex.lb, ex.ub];
            opts = imfil_optset('complete_history','off');
            
            imfil(ex.x0,imfilfun,ex.maxFunEvals,bounds,opts);
            
        case 'sid_psm'
            % local
            
            addpath('../algorithms/sid_psm_1.3');
            
            lb = ex.lb;
            ub = ex.ub;
            
            problem.func_f     = objfun;
            % 1 (>0) if any constraint violated
            problem.func_const = @(x) any(lb>x) || any(x>ub);
            problem.grad_const = @(x) zeros(ex.dim,1);
            
            sid_psm(problem,ex.x0,2,0);
            
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
            
            ga(objfun,ex.dim,[],[],[],[],ex.lb,ex.ub,[],[],options);
            
            
        case {'gps','gss','mads'}
            % local
            
            options = psoptimset(@patternsearch);
            options.MaxFunctionEvaluations = ex.maxFunEvals;
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIterations = ex.maxFunEvals + 1;
            options.MaxIter = ex.maxFunEvals + 1;
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
            
           patternsearch(objfun,ex.x0,[],[],[],[],ex.lb,ex.ub,[],options);
            
        case 'simulannealbnd'
            % local
            
            options = saoptimset;
            
            options.MaxFunctionEvaluations = ex.maxFunEvals;
            options.MaxFunEvals = ex.maxFunEvals;
            options.MaxIterations = ex.maxFunEvals + 1;
            options.MaxIter = ex.maxFunEvals + 1;
            options.Display = 'off';
            
            simulannealbnd(objfun,ex.x0,ex.lb,ex.ub,options);
            
        case 'particleswarm'
            % global
            
            options = optimoptions(@particleswarm);
            options.MaxIterations = ex.maxFunEvals + 1; % no MaxFunctionEvaluations field
            options.Display = 'off';
            
            particleswarm(objfun,ex.dim,ex.lb,ex.ub,options);
            
        otherwise
            error('y:solverunknown','Could not identify solver');
    end
       
    result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
                ex.alg,ex.x0,ex.maxFunEvals,...
                y_fbst,y_xbst,y_feval_counter,toc(starttic),y_flag_time,y_flag_fevals,y_arr_fval_trace);
    
catch ME
    if strcmp(ME.identifier,'y:stop')
        result = Result(ex.name,ex.dim,ex.lb,ex.ub,ex.fbst,ex.xbst,ex.smooth,ex.convex,ex.unimodal,...
            ex.alg,ex.x0,ex.maxFunEvals,...
            y_fbst,y_xbst,y_feval_counter,toc(starttic),y_flag_time,y_flag_fevals,y_arr_fval_trace);
    else
        rethrow(ME);
    end
end
    

end