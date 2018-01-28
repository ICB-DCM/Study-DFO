%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% chenhark.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function CHENHARK
%
k = 100;
n = 10*k;
nfree = 5*k;
ndegen = 2*k;
A = -2*diag(ones(n,1))+diag(ones(n-1,1),1)+diag(ones(n-1,1),-1);
A = [1 zeros(1,n-1); A; zeros(1,n-1) 1];
data.A = sparse(A);
clear A;
data.b = zeros(n+2,1);
data.c = [-3; 1; zeros(nfree-4,1); 1; -3; 5; -1; ones(n-nfree-2,1)];
data.gam = 0;
data.D = ones(n+2,1);
xl = zeros(n,1);
xu = Inf*ones(n,1);
x = 0.5*ones(n,1);
