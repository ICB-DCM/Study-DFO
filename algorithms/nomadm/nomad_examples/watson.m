function [f,cx,g,Jcx]=watson(x)
n=length(x);
d=x(2)-x(1)^2-1;
f=x(1)^2+d^2;
g(1)=2*x(1)-4*x(1)*d;
g(2)=2*d;
for j=3:n,g(j)=0;end
for i=2:30
   r=(i-1)/29;
   v=0;for j=2:n,v=v+(j-1)*x(j)*r^(j-2);end
   w=0;for j=1:n,w=w+x(j)*r^(j-1);end
   f=f+(v-w*w-1)^2;
   for k=1:n
      g(k)=g(k)+2*(v-w*w-1)*((k-1)*r^(k-2)-2*w*r^(k-1));
   end
end
g=g(:);
cx=[];Jcx=[];
