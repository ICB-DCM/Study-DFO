%*********************************************************************
% example_Omega:  User-supplied function for defining Omega, based on p.
% --------------------------------------------------------------------
%   Variables:
%     A     = Coefficient matrix for bound and linear constraints
%     l     = Lower bounds for A*x for any iterate x
%     u     = Upper bounds for A*x for any iterate x
%     plist = list of possible values of categorical variable
%*********************************************************************
function [A,l,u,plist] = exampleP_Omega(n);

% Set upper and lower bounds
plist{1} = {0, 1};
A = eye(n);
l = [-2; -2];
u = [ 2;  2];
return
