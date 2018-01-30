function X = simulateSSA(v,S,T,x0,Omega)

    %% SIMULATION
    % Initialization
    t = 0;
    X = zeros(length(x0),length(T));
    x      = x0 + 0;
    % Calculation of trajectory
    for i = 1:length(T)
        if t >= T(i) 
            % Save time point
            if i>1
                X(:,i) = X(:,i-1);
            else
                X(:,i) = x0 + 0;
            end
        else
            % Simulate till next time point

            %##################################################################
            % Comment Dennis: This loop contains all runtime critical lines
%             while t < T(i)
%                 [t, I] = simulateSSA_innerfun(x,Omega, t);
% 
%                 % Check whether state has to be saved
%                 if t >= T(i)
%                     % Save time point
%                     X(:,i) = x;       
%                 end
% 
%                 % Update of state
%                 x = x + S(:,I);
%             end
            %##################################################################
            [t, x, xNew] = SSA_gene_enzyme(x,Omega, t, T(i));
            X(:,i) = xNew; 

        end
    end
end