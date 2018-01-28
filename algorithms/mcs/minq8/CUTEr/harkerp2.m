%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% harkerp2.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function HARKERP2
%
n = 1000;
data.gam = 0;
data.c = -ones(n,1);
data.D = [-ones(n,1); 2; 4*ones(n-1,1)];
data.A = sparse([eye(n); triu(ones(n,n))]);
data.b = zeros(2*n,1);
xl = zeros(n,1);
xu = Inf*ones(n,1);
x = (1:n)';