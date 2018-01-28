%*********************************************************************
% example_Omega:  User-supplied function for defining Omega, based on p.
% --------------------------------------------------------------------
%   Variables:
%     A  = Coefficient matrix for bound and linear constraints
%     l  = Lower bounds for A*x for any iterate x
%     u  = Upper bounds for A*x for any iterate x
%*********************************************************************
function [A,l,u] = exampleCPU_Omega(n)

% Set upper and lower bounds
A = eye(n);
l = -10*ones(n,1);
u =  10*ones(n,1);
%A = [A; 1 2 1];
%l = [l;-19];
%u = [u; Inf];
return
