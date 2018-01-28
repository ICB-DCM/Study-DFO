%*********************************************************************
% degenerate2_Omega:  User-supplied function for defining Omega, based on p.
% --------------------------------------------------------------------
%   Variables:
%     A  = Coefficient matrix for bound and linear constraints
%     l  = Lower bounds for A*x for any iterate x
%     u  = Upper bounds for A*x for any iterate x
%*********************************************************************
function [A,l,u] = degenerate2_Omega(n);

% Set upper and lower bounds

B = [1, 1; 2, 1; 1, 2; 3, 1; 1, 3];
A = [eye(n); B];
l = [ 0; -inf; 0;   0;   0;   0;  -inf];
u = [inf;  0; inf; inf; inf; inf;   0];
return
