

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ldldown.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [L,d]=ldldown(L,d,j)
% downdates LDL^T factorization when j-th row and column are replaced 
% by j-th unit vector
%
% d contains diag(D) and is assumed positive
%
function [L,d]=ldldown(L,d,j);

n=size(d,1);

test=0;
if test,
  disp('enter ldldown')
  A=L*diag(d)*L';A(:,j)=zeros(n,1);A(j,:)=zeros(1,n);A(j,j)=1; 
end;

if j<n,
  K=j+1:n;
  [L(K,K),d(K)]=ldlrk1(L(K,K),d(K),d(j),L(K,j));
  L(K,j)=zeros(n-j,1);
end;
L(j,1:j-1)=zeros(1,j-1);
d(j)=1;

if test, 
  A1=L*diag(d)*L',A 
  quot=norm(A1-A,1)/norm(A,1), 
  disp('leave ldldown')
end;
