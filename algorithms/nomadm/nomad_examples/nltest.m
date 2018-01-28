function [fx,cx,gradfx,gradcx] = nltest(x);


fx = (x(1)-2)^2 + (x(2)-1)^2 ;
gradfx = [2*(x(1)-2);
          2*(x(2)-1); 
             0];

m=2;
%cx = [];
%gradfx = [];
%gradcx = [];
%cx = ones(1,m); %initialize
cx = 0.25*x(1)^2 + x(2)^2 - 1 + x(3);   %x(3) is a slack
%cx(2) = 1e8*(x(1) - 2*x(2) - 1);
%cx

%gradcx = 1e8*[0.5*x(1) ,  1;
%                2*x(2) , -2;
%                1      ,  0];
        
gradcx = [0.5*x(1);
            2*x(2);
            1    ];


return;