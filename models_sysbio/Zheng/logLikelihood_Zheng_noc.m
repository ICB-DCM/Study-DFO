function varargout = loglikelihood_Zheng_noc(xi,D,simfct,options)
% Likelihood function for the case of NO additional proportionality
% parameters.

nderiv = nargout-1;
options.ami.sx0 = zeros(15,45);        
options.ami.maxsteps = 1e6;
options.ami.atol = 1e-8;
options.ami.rtol = 1e-6;

if ~isfield(options.llh,'save_analytical')
    options.llh.save_analytical = false;
end
if(nderiv>=1)
    options.ami.sensi = 1;
else
    options.ami.sensi = 0;
end
try
    sol= simfct(D(1).t,xi,options);
catch
    varargout{1} = NaN;
    if nderiv>=1
        varargout{2} = nan(numel(xi),1);
    end
    warning('simulation failed')
    return;
end

if (sol.status<0)
    varargout{1} = NaN;
    if nderiv>=1
        varargout{2} = nan(numel(xi),1);
    end
    warning('simulation failed');
    return;
end
sol.y = permute(sol.y,[2,1]);
if nderiv > 0
    sol.sy = permute(sol.sy,[2,1,3]);
end
D.my = permute(D.my,[2,1,3]);
switch options.llh.approach
    case 'hierarchical'
        if nderiv == 0
            logL = loglikelihoodHierarchical(sol,D,options.llh.distribution,options.llh,options.llh.save_analytical);
        else
            [logL,dlogL] = loglikelihoodHierarchical(sol,D,options.llh.distribution,options.llh,options.llh.save_analytical);
        end
    case 'standard'
        sigma2 = 10.^xi(end)*ones(1,1); 
        if nderiv > 0
            dsigma2 = zeros(1,4,numel(xi));
            dsigma2(1,:,end) = log(10)*sigma2;
        end
        y_ch = bsxfun(@minus,D.my,sol.y);
        if nderiv > 0
            dcy_cdy = sol.sy;
            if strcmp(options.llh.approach,'standard')
                dcy_cdy(:,:,46) = 0;
            end
        end
        switch options.llh.distribution
            case 'laplace'
                logL = -sum(sum(nansum(bsxfun(@times,~isnan(D.my),log(2*sigma2))+...
                    bsxfun(@rdivide,abs(y_ch),sigma2),1),3),2);
                if nargout > 1
                    dlogL = -permute(sum(sum(nansum(...
                        bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,abs(y_ch),sigma2)),...
                        sigma2),[1,2,4,3]),dsigma2)-...
                        bsxfun(@times,permute(bsxfun(@rdivide,sign(y_ch),sigma2),[1,2,4,3]),dcy_cdy)...
                        ,1),4),2),[3,2,1]);
                end
            case 'normal'
                logL = -0.5*(sum(sum(nansum(bsxfun(@times,~isnan(D.my),log(2*pi*sigma2))+...
                    bsxfun(@rdivide,bsxfun(@power,y_ch,2),sigma2),1),3),2));
                if nargout > 1
                    dlogL = -0.5*(permute(sum(sum(nansum(...
                        bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,...
                        bsxfun(@power,y_ch,2),sigma2)),sigma2),[1,2,4,3]),dsigma2) -...
                        bsxfun(@times,permute(2*bsxfun(@rdivide,y_ch,sigma2),[1,2,4,3]),dcy_cdy)...
                        ,1),4),2),[3,2,1]));
                end
        end
end

if options.llh.prior.flag
    logL = logL - 0.5*nansum((xi-options.llh.prior.mean).^2./...
        options.llh.prior.sigma2);
    if nargout > 1
        dlogL = -nansum([dlogL,(xi-options.llh.prior.mean)./...
            options.llh.prior.sigma2],2);
    end
end

varargout{1} = logL;
if nderiv>=1
    varargout{2} = dlogL;
end