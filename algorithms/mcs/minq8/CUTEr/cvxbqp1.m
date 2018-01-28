%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cvxbqp1.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function CVXBQP1
% n should be set to 1000 or 10000
%
n = 1000; % n = 1000 or 10000
data.gam = 0;
data.c = zeros(n,1);
data.D = (1:n)';
data.b = zeros(n,1);
A = eye(n);
for i=1:n
  A(i,mod(2*i-1,n)+1) = A(i,mod(2*i-1,n)+1)+1;
  A(i,mod(3*i-1,n)+1) = A(i,mod(3*i-1,n)+1)+1;
end
data.A = sparse(A);
clear A;
xl = 0.1*ones(n,1);
xu = 10*ones(n,1);
x = 0.5*ones(n,1);
