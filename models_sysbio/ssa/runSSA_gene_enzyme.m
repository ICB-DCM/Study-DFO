function [t,X,m,C] = runSSA_gene_enzyme(Omega,t,N)

cE0 = 1;

x0 = [0;0;round(cE0*Omega)];

batchsize = 50000;

% Simulation
X_temp = zeros(length(t),3,min(N,batchsize));
X = zeros(length(t),3,N);

for k = 1:floor(N/batchsize)
    disp(['simulating batch ' num2str(k) ' of ' num2str(ceil(N/batchsize))]);
    parfor i = 1:batchsize
        % disp(['   Simulation ' num2str(i,'%d')]);
        X_temp(:,:,i) = simulateSSA([],[],t,x0,Omega)';
    end 
    X(:,:,((k-1)*batchsize+1):(k*batchsize)) = X_temp;
end
disp(['simulating batch ' num2str(k+1) ' of ' num2str(ceil(N/batchsize))]);

for i = 1:mod(N,batchsize)
	% disp(['   Simulation ' num2str(i,'%d')]);
	X_temp(:,:,i) = simulateSSA([],[],t,x0,Omega)';
end
X(:,:,(floor(N/batchsize)*batchsize+1):N) = X_temp(:,:,1:mod(N,batchsize));



%% Calculation of statistics
m = zeros(length(t),3);
C = zeros(length(t),6);
% for k = 1:length(t)
% 	m(k,:) = mean(X(k,:,:),3)/Omega;
%     COV_SSA = cov(squeeze(X(k,:,:))');
%     C(k,:) = [COV_SSA(1,1),COV_SSA(2,1),COV_SSA(2,2),COV_SSA(3,1),COV_SSA(3,2),COV_SSA(3,3)]/Omega^2;    
% end

% %% Visualization
% figure;
% for i = 1:nx
%     subplot(2,2,i);
%     fill(t([1:end,end:-1:1]),m([1:end,end:-1:1],i)+[sqrt(C(1:end,sum(1:i)));-sqrt(C(end:-1:1,sum(1:i)))],0.9*[1,1,1]); hold on;
%     plot(t,m(:,i),'k-','linewidth',2);
%     % Legend/Label
%     xlim(t([1,end]));
%     xlabel('time, t');
%     ylabel(species_name{i});
% end
