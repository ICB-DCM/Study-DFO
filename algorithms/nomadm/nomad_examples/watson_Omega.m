function [A,l,u] = watson_Omega(n);
A = eye(n);
l = -10*ones(n,1);
u = 10*ones(n,1);