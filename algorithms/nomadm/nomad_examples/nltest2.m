function [fx,cx,gradfx,gradcx] = nltest2(x);


fx = (x(1)-2)^2 + (x(2)-1)^2 ;
gradfx = [2*(x(1)-2);
          2*(x(2)-1); 
             0];

m=2;

%weight values
w = [0.1 1000];

%cx = [];
%gradfx = [];
%gradcx = [];
cx = ones(1,m); %initialize
cx(1) = w(1)*(0.25*x(1)^2 + x(2)^2 - 1 + x(3));   %x(3) is a slack
cx(2) = w(2)*(x(1) - 2*x(2) - 1);
%cx

gradcx = [0.5*x(1)*w(1) ,  1*w(2);
            2*x(2)*w(1) , -2*w(2);
            1*w(1)      ,  0*w(2)];

%gradcx = [0.5*x(1);
%            2*x(2);
%            1    ];


return;