

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ldlup.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [L,d,p]=ldlup(L,d,j,g)
% updates LDL^T factorization when a unit j-th row and column
% are replaced by column g 
% if the new matrix is definite (signalled by p=[]);
% otherwise, the original L,d and 
% a direction p of null or negative curvature are returned
%
% d contains diag(D) and is assumed positive
% Note that g must have zeros in other unit rows!!!
%
function [L,d,p]=ldlup(L,d,j,g)

test=0;
if test, 
  disp('enter ldlup')
  A=L*diag(d)*L';A(:,j)=g;A(j,:)=g'; 
end;

n=size(d,1);
I=1:j-1;K=j+1:n;
if j==1,
  v=[];
  del=g(j);
  if del<=n*eps, 
    p=[1;zeros(n-1,1)]; 
    if test, 
      A,p
      Nenner=abs(p)'*abs(A)*abs(p);
      if Nenner==0, indef1=0 ,else indef1=(p'*A*p)/Nenner, end;
      disp('leave ldlup at 1')
    end;
    return; 
  end;
  w=g(K)/del;
else
  u=L(I,I)\g(I);
  v=u./d(I);
  del=g(j)-u'*v;
  if del<=n*eps,
    p=[L(I,I)'\v;-1;zeros(n-j,1)];
    if test, 
      A,p
      indef1=(p'*A*p)/(abs(p)'*abs(A)*abs(p))
      disp('leave ldlup at 2')
    end;
    return;
  end;
  w=(g(K)-L(K,I)*u)/del;
end;
if isempty(K)
  L(j,I)=v';
  d(j)=del;
  if test, 
    A1=L*diag(d)*L',A 
    quot=norm(A1-A,1)/norm(A,1), 
    disp('leave ldlup at 3')
  end;
  return;  
end;
[L(K,K),d(K),q]=ldlrk1(L(K,K),d(K),-del,w);
if isempty(q)
  L(j,I)=v';
  d(j)=del;
  L(K,j)=w;
  if test, 
    A1=L*diag(d)*L',A 
    quot=norm(A1-A,1)/norm(A,1), 
    disp('leave ldlup at 4')
  end;
else
  pi=w'*q;
  p=[L(I,I)'\(pi*v-L(K,I)'*q);-pi;q];
  if test, 
    indef2=(p'*A*p)/(abs(p)'*abs(A)*abs(p)), 
    disp('leave ldlup at 5')
  end;
end;

