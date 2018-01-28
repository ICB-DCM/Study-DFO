function [fx,cx,varargout] = exampleP(x,p);

fx1 = x(1)^2 + x(2)^2;
fx2 = x(1)^2*x(2) + x(1)*(1-x(2));

fx = fx1*(1-p{1}) + fx2*p{1};
cx = [];
varargout = {[2*x(1)*(1-p{1})+(2*x(1)*x(2)+1)*p{1}; 2*x(2)*(1-p{1})+(x(1)^2-x(1))*p{1}],[]};
return;
