%*********************************************************************
% examplePF_Omega:  User-supplied function for defining Omega, based on p.
% --------------------------------------------------------------------
%   Variables:
%     p  = Vector of categorical variables
%     A  = Coefficient matrix for bound and linear constraints
%     l  = Lower bounds for A*x for any iterate x
%     u  = Upper bounds for A*x for any iterate x
%*********************************************************************
function [A,l,u,plist] = examplePF_Omega(n,p);

% Set upper and lower bounds
plist{1} = {'0', '1'};
A = eye(n);
l = [-2; -2];
u = [ 2;  2];
return
