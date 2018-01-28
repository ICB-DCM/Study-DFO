function [fx,cx,gradfx,gradcx] = SimpleMultiFi(x)

fx     = -sin(x(1))*sin(x(2));
cx(1)  = exp(x(1))*x(2) - 5;
cx(2)  = -exp(x(1))*x(2) - 5;
cx(3)  = sin(x(1))*cos(x(2)) - 1;
cx(4)  = -sin(x(1))*cos(x(2)) - 2;
gradfx = [-cos(x(1))*sin(x(2)); -sin(x(1))*cos(x(2))];
gradcx = [ exp(x(1))*x(2),  exp(x(1));
          -exp(x(1))*x(2), -exp(x(1)); 
           cos(x(1))*cos(x(2)), -sin(x(1))*sin(x(2)); 
          -cos(x(1))*cos(x(2)),  sin(x(1))*sin(x(2));];
return
