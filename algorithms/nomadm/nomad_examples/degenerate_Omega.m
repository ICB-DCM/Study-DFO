function [A,l,u] = degenerate_Omega(n)

B = -2*ones(n);
A = [ eye(n); eye(n) + B - diag(diag(B)) ];
l = [zeros(n,1); -inf(n,1)];
u = [inf(n,1);   zeros(n,1)];
return
