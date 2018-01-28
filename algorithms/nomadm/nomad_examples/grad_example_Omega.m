%*********************************************************************
% GradExample_Omega:  User-supplied function for defining Omega.
% --------------------------------------------------------------------
%   Variables:
%     A  = Coefficient matrix for bound and linear constraints
%     l  = Lower bounds for A*x for any iterate x
%     u  = Upper bounds for A*x for any iterate x
%*********************************************************************
function [A,l,u] = grad_example_Omega(n);

% Set upper and lower bounds
A = eye(n);
l = [-5;-5];
u = [ 10; 10];
return
