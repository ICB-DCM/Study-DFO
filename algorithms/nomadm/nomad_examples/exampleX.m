function [fx,cx,gradfx,gradcx] = exampleX(x);

fx = sum(x);
gradfx = ones(length(x),1);
cx = [];
gradcx = [];
%cx(1) = norm(x)^2 - 1;
%gradcx = 2*x;
return;
