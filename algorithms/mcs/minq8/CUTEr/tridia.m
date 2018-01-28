%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% tridia.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function TRIDIA
%
n = 500;
data.gam = 0;
data.c = zeros(n,1);
data.D = 2*(1:n)';
data.b = [1; zeros(n-1,1)];
A = 2*eye(n)-diag(ones(n-1,1),-1);
A(1,1) = 1;
data.A = sparse(A);
clear A;
xu = Inf*ones(n,1);
xl = -xu;
x = ones(n,1);
