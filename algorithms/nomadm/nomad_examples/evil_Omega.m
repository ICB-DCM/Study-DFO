%*********************************************************************
% evil_Omega:  User-supplied function for defining Omega, based on p.
% --------------------------------------------------------------------
%   Variables:
%     A  = Coefficient matrix for bound and linear constraints
%     l  = Lower bounds for A*x for any iterate x
%     u  = Upper bounds for A*x for any iterate x
%*********************************************************************
function [A,l,u] = evil_Omega(n);

% Set upper and lower bounds

A = eye(n);
l = [0;0];
u = [ 50; 50];
return
