%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% biggsb1.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function BIGGSB1
%
n = 1000;
data.gam = 0;
data.c = zeros(n,1);
data.b = [1; zeros(n-1,1); 1];
data.D = 2*ones(n+1,1);
data.A = sparse([1 zeros(1,n-1);eye(n)-diag(ones(n-1,1),1)]);
xl = [zeros(n-1,1); -Inf];
xu = [0.9*ones(n-1,1); Inf];
x = zeros(n,1);