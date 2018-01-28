function [fx,cx,gradfx,gradcx] = grad_example(x)

fx = x(1)^3 + x(2)^3 - 10*(x(1)^2 + x(2)^2);
gradfx = 3*x.*x - 20*x;
cx = [];
gradcx = [];
return;
