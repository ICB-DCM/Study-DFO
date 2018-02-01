function varargout = loglikelihood_Bachmann(xi,D,options)
nderiv = nargout-1;

if(nderiv>=1)
    options.ami.sensi = 1;
else
    options.ami.sensi = 0;
end
if ~isfield(options.llh,'lsqnonlin')
    options.llh.lsqnonlin = 0;
end
if ~isfield(options.llh,'linRNA')
    options.llh.liNRNA = 0;
end
if ~isfield(options.llh,'save_analytical')
    options.llh.save_analytical = false;
end

% Simulation of conditions
try
    for cond = 1:numel(D)
        options.ami.x0 = D(cond).init(xi,D(cond).u);
        if options.ami.sensi
            options.ami.sx0 = D(cond).sinit(xi,D(cond).u);
        end
        switch options.llh.modeltype
            case 'reduced'
                if cond == 13 || cond == 14
                    sol(cond) = simulate_Bachmann_JAKSTAT_SHP1oe(D(cond).t,xi(1:27),D(cond).u,[],options.ami);
                else
                    sol(cond) = simulate_Bachmann_JAKSTAT(D(cond).t,xi(1:27),D(cond).u,[],options.ami);
                end
            case 'foldchange'
                sol(cond) = simulate_Bachmann_JAKSTAT_foldchange(D(cond).t,xi(1:33),D(cond).u,[],options.ami);
                
        end
        if sol(cond).status < 0
            varargout{1} = nan;
            if nderiv>=1
                varargout{2} = nan(numel(xi),1);
            end
            warning('simulation failed');
            return;
        end
    end
catch
    varargout{1} = NaN;
    if nderiv>=1
        varargout{2} = nan(numel(xi),1);
    end
    warning('simulation failed')
    return;
end

res = [];
sres = [];
switch options.llh.approach
    case 'hierarchical'
        sol = getSimulation_Bachmann_JAKSTAT_offsetscaling(xi,sol,D,options);
%         if options.llh.lsqnonlin
%             if nderiv == 0
%                 res = neglogLikelihood_hierarchical(sol,D,options.llh.distribution,options.llh,options.llh.save_analytical);
%             else
%                 [res,sres] = neglogLikelihood_hierarchical(sol,D,options.llh.distribution,options.llh,options.llh.save_analytical);
%             end
%         else
            if nderiv == 0
                logL = loglikelihoodHierarchical(sol,D,options.llh.distribution,options.llh,options.llh.save_analytical);
            else
                [logL,dlogL] = loglikelihoodHierarchical(sol,D,options.llh.distribution,options.llh,options.llh.save_analytical);
            end
  %      end
    case 'standard'
        logL = 0;
        dlogL=zeros(numel(xi),1);
        sol = getSimulation_Bachmann_JAKSTAT_offsetscaling(xi,sol,D,options);
        for cond = 1:numel(D)
            % Map noise parameters
            sigma2 = zeros(1,20,size(D(cond).my,3));
            for r = 1:size(D(cond).my,3)
                sigma2(1,:,r) = (10.^(xi(D(cond).std)));
            end
            if nargout > 1
                dsigma2 = zeros(1,20,numel(xi),size(D(cond).my,3));
                for iobs = 1:20
                    dsigma2(1,iobs,D(cond).std(iobs),:) = dsigma2(1,iobs,D(cond).std(iobs),:) + ...
                        10.^(xi(D(cond).std(iobs)))*log(10);
                end
            end
            if cond == 3
                y_ch = nan(size(D(cond).my));
                y_ch(:,[12:17],:) = bsxfun(@minus,(D(cond).my(:,[12:17],:)),...
                    (sol(cond).y(:,[12:17])));
            elseif cond == 2
                y_ch = nan(size(D(cond).my));
                y_ch(:,11,:) = bsxfun(@minus,(D(cond).my(:,11,:)),(sol(cond).y(:,11)));
                y_ch(:,[1:10,12:end],:) = bsxfun(@minus,log10(D(cond).my(:,[1:10,12:end],:)),...
                    log10(sol(cond).y(:,[1:10,12:end])));
            else
                y_ch = bsxfun(@minus,log10(D(cond).my),log10(sol(cond).y));
            end
            switch options.llh.distribution
                case 'normal'
                    logL = logL - 0.5*(sum(sum(nansum(bsxfun(@times,~isnan(D(cond).my),...
                        log(2*pi*sigma2))+bsxfun(@rdivide,bsxfun(@power,y_ch,2),sigma2),1),3),2));
                    if nargout > 1
                        if cond == 3 && options.llh.linRNA
                            iy = [12:17];
                            dlogL = dlogL - 0.5*(permute(sum(sum(nansum(...
                                bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,...
                                bsxfun(@power,y_ch(:,iy,:),2),sigma2(:,iy,:))),sigma2(:,iy,:)),[1,2,4,3]),dsigma2(:,iy,:,:)) -...
                                bsxfun(@times,permute(2*bsxfun(@rdivide,y_ch(:,iy,:),sigma2(:,iy,:)),[1,2,4,3]),sol(cond).sy(:,iy,:))...
                                ,1),4),2),[3,2,1]));
                        elseif cond == 2
                            iy = [1:10,12:20];
                            dlogL = dlogL - 0.5*(permute(sum(sum(nansum(...
                                bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,...
                                bsxfun(@power,y_ch(:,iy,:),2),sigma2(:,iy,:))),sigma2(:,iy,:)),[1,2,4,3]),dsigma2(:,iy,:,:)) -...
                                bsxfun(@times,1/log(10)*permute(2*bsxfun(@rdivide,y_ch(:,iy,:),sigma2(:,iy,:)),[1,2,4,3]),...
                                bsxfun(@rdivide,sol(cond).sy(:,iy,:),sol(cond).y(:,iy)))...
                                ,1),4),2),[3,2,1]));
                            iy = 11;
                            dlogL = dlogL - 0.5*(permute(sum(sum(nansum(...
                                bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,...
                                bsxfun(@power,y_ch(:,iy,:),2),sigma2(:,iy,:))),sigma2(:,iy,:)),[1,2,4,3]),dsigma2(:,iy,:,:)) -...
                                bsxfun(@times,permute(2*bsxfun(@rdivide,y_ch(:,iy,:),sigma2(:,iy,:)),[1,2,4,3]),sol(cond).sy(:,iy,:))...
                                ,1),4),2),[3,2,1]));
                        else
                            dlogL = dlogL - 0.5*(permute(sum(sum(nansum(...
                                bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,...
                                bsxfun(@power,y_ch,2),sigma2)),sigma2),[1,2,4,3]),dsigma2) -...
                                bsxfun(@times,1/log(10)*permute(2*bsxfun(@rdivide,y_ch,sigma2),[1,2,4,3]),...
                                bsxfun(@rdivide,sol(cond).sy,sol(cond).y))...
                                ,1),4),2),[3,2,1]));
                        end
                    end
                case 'laplace'
                    logL = logL - sum(sum(nansum(bsxfun(@times,~isnan(D(cond).my),log(2*sigma2))+...
                        bsxfun(@rdivide,abs(y_ch),sigma2),1),3),2);

                    if nargout > 1
                        if cond == 3 && options.llh.linRNA
                            iy = [12:17];
                            dlogL = dlogL - permute(sum(sum(nansum(...
                                bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,abs(y_ch(:,iy,:)),sigma2(:,iy,:))),...
                                sigma2(:,iy,:)),[1,2,4,3]),dsigma2(:,iy,:,:))-...
                                bsxfun(@times,permute(bsxfun(@rdivide,sign(y_ch(:,iy,:)),...
                                sigma2(:,iy,:)),[1,2,4,3]),sol(cond).sy(:,iy,:))...
                                ,1),4),2),[3,2,1]);
                        elseif cond == 2
                            iy = [1:10,12:20];
                            dlogL = dlogL - permute(sum(sum(nansum(...
                                bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,...
                                abs(y_ch(:,iy,:)),sigma2(:,iy,:))),...
                                sigma2(:,iy,:)),[1,2,4,3]),dsigma2(:,iy,:,:))-...
                                bsxfun(@times,1/log(10)*permute(bsxfun(@rdivide,...
                                sign(y_ch(:,iy,:)),sigma2(:,iy,:)),[1,2,4,3]),...
                                bsxfun(@rdivide,sol(cond).sy(:,iy,:),sol(cond).y(:,iy)))...
                                ,1),4),2),[3,2,1]);
                            iy = 11;
                            dlogL = dlogL - permute(sum(sum(nansum(...
                                bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,abs(y_ch(:,iy,:)),sigma2(:,iy,:))),...
                                sigma2(:,iy,:)),[1,2,4,3]),dsigma2(:,iy,:,:))-...
                                bsxfun(@times,permute(bsxfun(@rdivide,sign(y_ch(:,iy,:)),...
                                sigma2(:,iy,:)),[1,2,4,3]),sol(cond).sy(:,iy,:))...
                                ,1),4),2),[3,2,1]);
                        else
                            dlogL = dlogL - permute(sum(sum(nansum(...
                                bsxfun(@times,permute(bsxfun(@rdivide,(1-bsxfun(@rdivide,abs(y_ch),sigma2)),...
                                sigma2),[1,2,4,3]),dsigma2)-...
                                bsxfun(@times,1/log(10)*permute(bsxfun(@rdivide,sign(y_ch),sigma2),[1,2,4,3]),...
                                bsxfun(@rdivide,sol(cond).sy,sol(cond).y))...
                                ,1),4),2),[3,2,1]);
                        end
                    end
                    
            end
          
        end
end

if isfield(options.llh,'parameter_prior')
    if options.llh.lsqnonlin
        error('todo: include res for prior')
    else
        logL = logL - 0.5*nansum((xi-options.llh.parameter_prior.mean).^2./ options.llh.parameter_prior.sigma2);
        if nargout > 1
            dlogL = nansum([dlogL,-(xi-options.llh.parameter_prior.mean)./ options.llh.parameter_prior.sigma2],2);
            
        end
    end
end

if options.llh.lsqnonlin
    ind = find(~isnan(res));
    varargout{1} = res(ind);
    if nderiv>=1
        if options.llh.reduced_woinit
            varargout{2} = sres(ind,[1:24,27:end]);
        else
            varargout{2} = sres(ind,:);
        end
    end
else
    varargout{1} = logL;
    if nderiv>=1
        varargout{2} = dlogL;
    end
end