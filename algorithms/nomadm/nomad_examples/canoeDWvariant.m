function [fx,cx] = canoeDW(x);
c = [-1; 1];
fx = 0.5*max(norm(x-c)^2,norm(x+c)^2);
cx = [];
return
