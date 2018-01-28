%*********************************************************************
% Example_Omega:  User-supplied function for defining Omega, based on p.
% --------------------------------------------------------------------
%   Variables:
%     A  = Coefficient matrix for bound and linear constraints
%     l  = Lower bounds for A*x for any iterate x
%     u  = Upper bounds for A*x for any iterate x
%*********************************************************************
function [A,l,u] = lar_Omega(n);

% Set upper and lower bounds
%n = 2;
A = eye(n);
l = [-10;-10];
u = [10; 10];
return
