function [fx,cx] = canoeDW(x);
a1 = [1; -1];
a2 = -a1;
fx = 0.5*max(norm(x-a1)^2,norm(x-a2)^2)+rand();
cx = [];
return
