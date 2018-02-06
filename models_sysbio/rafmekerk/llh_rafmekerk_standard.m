function [varargout] = nllh_rafmekerk_standard(theta, D)

    
    %% Objective Function Evaluation
    
    % Initialization
    llh = 0;
    sllh = zeros(28, 1);
    s2llh = zeros(28, 28);
    
    % Integration
    if (nargout == 1)
        amiOptions.sensi = 0;
        for j = 1 : 3
            sol = simulate_rafmekerk_standard(D(j).t, theta, D(j).k, D(j), amiOptions);
            if sol.status < 0
                llh = -inf;
            end
            llh = llh + sol.llh;
        end
        
    elseif (nargout == 2)
        amiOptions.sensi = 1;
        for j = 1 : 3
            sol = simulate_rafmekerk_standard(D(j).t, theta, D(j).k, D(j), amiOptions);
            if sol.status < 0
                llh = -inf;
            end
            llh = llh + sol.llh;
            sllh = sllh + sol.sllh;
        end
        
    elseif (nargout == 3)
        amiOptions.sensi = 2;
        for j = 1 : 3
            sol = simulate_rafmekerk_standard(D(j).t, theta, D(j).k, D(j), amiOptions);
            if sol.status < 0
                llh = -inf;
            end
            
            % Hessian matrix approximation from 1st order sensitivities
            hessian = zeros(28);       % preallocation
            nT = length(D(j).t);       % timepoints
            res = D(j).Y - sol.y;
            res(isnan(res)) = 0;
            for iT = 1 : nT
                if (~isnan(D(j).Y(iT,1)))
                    resi = res(iT,1);
                    sigma = sol.sigmay(iT,1);
                    sy(:) = sol.sy(iT,1,:);
                    ssigmay(:) = sol.ssigmay(iT,1,:);

                    cross = 2*resi/sigma^3 * (sy'*ssigmay + ssigmay'*sy);
                    sigma_cross = 3*resi^2/sigma^4 * (ssigmay'*ssigmay);

                    hessian = hessian ...
                        - (sy'*sy - ssigmay'*ssigmay) / sigma^2 ...     FIM contribution
                        - cross ...                                     cross terms
                        - sigma_cross;                                % 2nd order derivatives
                end
            end
            llh = llh + sol.llh;
            sllh = sllh + sol.sllh;
            s2llh = s2llh + hessian;
        end

    end
    
    % Assignment
    switch (nargout)
        case{0,1}
            varargout{1} = llh;
            
        case 2
            varargout{1} = llh;
            varargout{2} = sllh;
            
        case 3
            varargout{1} = llh;
            varargout{2} = sllh;
            varargout{3} = s2llh;
    end

end