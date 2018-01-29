function [A,l,u]= fobj_nomad_Omega (n)
A = [eye(n)];
l= [ -1; -1; ];
u= [ 1; 1; ];
return
