%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% qudlin.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function QUDLIN
% n should be set to 1200 or 5000
%
n = 5000; % n = 1200 or 5000
m = n/2;
data.gam = 0;
data.c = -10*(1:n)';
data.b = zeros(n,1);
data.D = 0.5*[ones(m,1); -ones(m,1)];
A1 = eye(m)+diag(ones(m-1,1),1);
A2 = eye(m)-diag(ones(m-1,1),1);
data.A = [[A1; A2] zeros(n,m)];
data.A(m,m+1)=1;
data.A(n,m+1)=-1;
clear A1 A2
xl = zeros(n,1);
xu = 10*ones(n,1);
x = ones(n,1);
