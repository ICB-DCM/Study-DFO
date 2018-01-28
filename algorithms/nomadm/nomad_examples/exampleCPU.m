function [fx,cx,gradfx,gradcx] = exampleCPU(x)

t = cputime;
n = length(x);
fx = sum(x);
gradfx = ones(n,1);
cx = [];
gradcx = [];
cx(1) = norm(x)^2 - 3*n;
gradcx = 2*x;

Param = getappdata(0,'PARAM');
Param.param = cputime - t;
setappdata(0,'PARAM',Param);

return
