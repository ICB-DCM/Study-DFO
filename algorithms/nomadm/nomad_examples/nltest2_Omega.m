%*********************************************************************
% Example_Omega:  User-supplied function for defining Omega, based on p.
% --------------------------------------------------------------------
%   Variables:
%     p  = Vector of categorical variables
%     A  = Coefficient matrix for bound and linear constraints
%     l  = Lower bounds for A*x for any iterate x
%     u  = Upper bounds for A*x for any iterate x
%*********************************************************************
function [A,l,u] = nltest2_Omega(n);



Epsilon = 1e-3;


% Set upper and lower bounds
A = [eye(n)];
%A = [A;
%     1 -2 0];
l = -3*ones(n,1);
l(3) = 0;
%l(4) = 1 - Epsilon;

u =  3*ones(n,1);
u(3) = 10;
%u(4) = 1 + Epsilon;
return
