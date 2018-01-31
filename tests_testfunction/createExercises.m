function [ cell_exercises ] = createExercises( solver, maxFunEvals, nStarts, bool_noise )
%CREATEEXERCISES

        % create function list
        
        list_arbdim = TF.f_getTestFunctions(true);
        nTfsArbDim = length(list_arbdim);
        list_fixeddim = TF.f_getTestFunctions(false);
        nTfsFixedDim = length(list_fixeddim);
        
        % add noise
        
        if bool_noise
            for jTf=1:nTfsArbDim
                tf = list_arbdim{jTf};
                tf.fun = TF.f_addNoise(tf.fun);
                list_arbdim{jTf} = tf;
            end
            for jTf=1:nTfsFixedDim
                tf = list_fixeddim{jTf};
                tf.fun = TF.f_addNoise(tf.fun);
                list_fixeddim{jTf} = tf;
            end
        end
        
        % local or global?
        solver_type = C.is_local_or_global(solver);
        
        % cell_exercises is to be filled
        if strcmp(solver_type,'local')
%             starts = C.nStarts_local;
%             maxFunEvals = C.maxFunEvals_local;
            
        elseif strcmp(solver_type,'global')
%             starts = C.nStarts_global;
%             maxFunEvals = C.maxFunEvals_global;
        else
            error('solver not recognized');
        end
        cell_exercises = cell((nTfsArbDim*C.nDims+nTfsFixedDim)*nStarts,1);            

        index = 0;
        
        % arbdim
        for jTf = 1:nTfsArbDim
            problem = list_arbdim{jTf};
            for jDim = 1:C.nDims
                dim = C.arr_dims(jDim);
                [lb,ub,xbst] = TF.f_getVectors(problem,dim);
                x0s = createUniformRandomPoints(lb,ub,nStarts);
                for jStart = 1:nStarts
                    index = index + 1;
                    cell_exercises{index} = Exercise(problem.name,problem.fun,dim,lb,ub,problem.fbst,xbst,problem.smooth,problem.convex,problem.unimodal,solver,x0s(:,jStart),maxFunEvals);
                end
            end
        end
        
        % fixeddim
        for jTf = 1:nTfsFixedDim
            problem = list_fixeddim{jTf};
            dim = problem.dim;
            [lb,ub,xbst] = TF.f_getVectors(problem,dim);
            x0s = createUniformRandomPoints(lb,ub,nStarts);
            for jStart = 1:nStarts
                index = index + 1;
                cell_exercises{index} = Exercise(problem.name,problem.fun,dim,lb,ub,problem.fbst,xbst,problem.smooth,problem.convex,problem.unimodal,solver,x0s(:,jStart),maxFunEvals);
            end
        end      

end