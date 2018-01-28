%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% pentdi.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function PENTDI
%
n = 5000;
data.gam = 0;
data.c = [-3 1 zeros(1,n/2-4) 1 -3 4 0 ones(1,n/2-2)]';
data.D = [12*ones(n,1); 2*ones(n-2,1); -2*ones(n-2,1); ones(n-2,1); -ones(n-2,1)];
data.b = zeros(5*n-8,1);
B1 = eye(n)-diag(ones(n-1,1),1);
B2 = eye(n)+diag(ones(n-1,1),1);
C1 = eye(n)+diag(ones(n-2,1),2);
C2 = eye(n)-diag(ones(n-2,1),2);
A = sparse([eye(n); B1(1:n-2,:); B2(1:n-2,:); C1(1:n-2,:); C2(1:n-2,:)]);
data.A = A;
clear A B1 B2 C1 C2;
xl = zeros(n,1);
xu = Inf*ones(n,1);
x = ones(n,1);
