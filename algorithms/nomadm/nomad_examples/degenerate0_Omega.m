function [A,l,u] = degenerate0_Omega(n)

B = -2*ones(n);
A = [ eye(n); eye(n) + B - diag(diag(B)) ];
l = [zeros(n,1); -inf(n,1)];
u = [inf(n,1); zeros(n,1)];

%ind = randperm(2*n);
%A = A(ind,:);
%l = l(ind);
%u = u(ind);

return
