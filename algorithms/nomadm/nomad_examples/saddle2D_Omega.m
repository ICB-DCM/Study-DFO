%*********************************************************************
% saddle2D_Omega:  User-supplied function for defining Omega, based on p.
%*********************************************************************
function [A,l,u] = saddle2D_Omega(n);
A = eye(n);
l = [-2;-2];
u = [ 2; 2];
return
