%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dqdrtic.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script defining the data structure data containing the function
% parameters, the default box bounds xl and xu and the default starting 
% point x for the CUTEr test set function DQDRTIC
n = 5000;
data.gam = 0;
data.c = zeros(n,1);
data.D = 2*[1; 101; 201*ones(n-4,1); 200; 100];
data.b = zeros(n,1);
data.A = sparse(eye(n));
xu = Inf*ones(n,1);
xl = -xu;
x = 3*ones(n,1);

