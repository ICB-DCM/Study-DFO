function [fx,cx,gradfx,gradcx] = example(x)

n      = length(x);
fx     = sum(x);
gradfx = ones(n,1);
cx(1)  = norm(x)^2 - 3*n;
gradcx = 2*x;
return
