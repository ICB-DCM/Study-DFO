%*********************************************************************
% degenerate3_Omega:  User-supplied function for defining Omega, based on p.
% --------------------------------------------------------------------
%   Variables:
%     A  = Coefficient matrix for bound and linear constraints
%     l  = Lower bounds for A*x for any iterate x
%     u  = Upper bounds for A*x for any iterate x
%*********************************************************************
function [A,l,u] = degenerate3_Omega(n);

% Set upper and lower bounds

B = [1, -2, -2;  -2, 1, -2;  -2, -2, 1];
A = [eye(n); B];
l = [ 0; 0; 0; -inf; -inf; -inf];
u = [inf; inf; inf; 0; 0; 0];
return
