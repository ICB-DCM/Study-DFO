%*********************************************************************
% canoeDW_Omega:  User-supplied function for defining Omega, based on p.
%*********************************************************************
function [A,l,u] = canoeDW_Omega(n);

A = eye(n);
l = [-5;-5];
u = [ 5; 5];
return
