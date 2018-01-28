%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dixon3dq.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function DIXON3DQ
% 
n = 10000;
data.gam = 0;
data.D = 2*ones(n,1);
data.c = zeros(n,1);
data.b = [1; zeros(n-2,1); 1];
data.A = sparse(eye(n)-diag(ones(n-1,1),1));
data.A(1,2) = 0;
xu = Inf*ones(n,1);
xl = -xu;
x = -ones(n,1);