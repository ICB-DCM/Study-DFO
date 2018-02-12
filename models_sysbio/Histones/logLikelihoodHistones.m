function varargout = logLikelihoodHistones(theta, amiData)
 
    switch nargout
        case 1
            sens = 0;
        case {2,3}
            sens = 1;
    end

    amiOptions = struct(...
        'atol', 1e-15, ...
        'rtol', 1e-10, ...
        'sensi_meth', 'forward', ...
        'sensi', sens);

    solPre = simulate_histonesPre([50, inf], theta, amiData.condition, [], amiOptions);
    
    x0 = solPre.x(2,:)';
    amiOptions.x0  = x0;
    
    if (nargout > 1)
        sx0 = squeeze(solPre.sx(2,:,:));
        amiOptions.sx0 = sx0;
    end

    sol = simulate_histones(amiData.t, theta, amiData.condition, amiData, amiOptions);

    if (nargout > 2)
        % compute Hessian approximation from first order sensitivities
        hess = zeros(46);       % preallocation
        nT = length(amiData.t); % timepoints
        nO = 15;                % observables
        res = amiData.Y - sol.y;
        res(isnan(res)) = 0;
        for iT = 1 : nT
            for iO = 1 : nO
                if (~isnan(amiData.Y(iT,iO)))
                    resi = res(iT,iO);
                    sigma = sol.sigmay(iT,iO);
                    sy(:) = sol.sy(iT,iO,:);
                    ssigmay(:) = sol.ssigmay(iT,iO,:);

                    cross = 2*resi/sigma^3 * (sy'*ssigmay + ssigmay'*sy);
                    sigma_cross = 3*resi^2/sigma^4 * (ssigmay'*ssigmay);

                    hess = hess ...
                        - (sy'*sy - ssigmay'*ssigmay) / sigma^2 ...     FIM contribution
                        - cross ...                                     cross terms
                        - sigma_cross; %                                sigma terms 1st order
                end
            end
        end
    end 

    switch nargout
        case 1
            varargout{1} = sol.llh;
        case 2
            varargout{1} = sol.llh;
            varargout{2} = sol.sllh;
        case 3
            varargout{1} = sol.llh;
            varargout{2} = sol.sllh;
            varargout{3} = hess;
    end
end