% MINQ8
% minimization of bound constrained quadratic program
%
% The subdirectory ./CUTEr contains the test function from the CUTEr
% test set
%
%The following lists the remaining programs in alphabetic order
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% feasprob.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script for generating a problem of the form
% minimize 0.5*norm(x,2)^2
% subject to A*x >= b
% and solving it by solving the dual problem with MINQ8
% or for reading such a problem from a .mat file and solving it

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% fixbounds.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,f,g,ier] = fixbounds(x,f,g,d,xl,xu,data,ind)
% tries to fix as many coordinates as possible at bounds to achieve a 
% decrease in function value
%
% Input:
% x        starting point (vector of length n)
% f        its function value
% g        its gradient
% d        vector of length n, = 0.5*diag(data.G), data.G see below
% xl, xu   box bounds (vectors of length n, infinite entries allowed)
% data     data structure containing:
% data.gam scalar
% data.c   vector of length n
% data.A   mxn matrix
% data.b   vector of length m
% data.D   vector of length m
% data.G   Hessian, = data.A'*diag(data.D)*data.A (nxn matrix)
% ind      vector such that d(ind) is sorted in ascending order
%
% Output:
% x        current point
% f        its function value
% g        its gradient
% ier      error flag
%          = 0 regular completion
%          = 1 function is unbounded below
% 
% Calls the following subprogram:
% minq8fun.m
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% freebounds.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,f,g,ier] = freebounds(x,f,g,d,xl,xu,data)
% line search along a direction that allows for freeing bounds
% 
% Input:
% x        starting point (vector of length n)
% f        its function value
% g        its gradient
% d        vector of length n, = 0.5*diag(data.G), data.G see below
% xl, xu   box bounds (vectors of length n, infinite entries allowed)
% data     data structure containing:
% data.gam scalar
% data.c   vector of length n
% data.A   mxn matrix
% data.b   vector of length m
% data.D   vector of length m
% data.G   Hessian, = data.A'*diag(data.D)*data.A (nxn matrix)
% ind      vector such that d(ind) is sorted in ascending order
%
% Output:
% x        current point
% f        its function value
% g        its gradient
% ier      error flag
%          = 0 regular completion
%          = 1 function is unbounded below
% 
% Calls the following subprograms:
% minq8fun.m
% qls.m 
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% minq8fun.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [f,g] = minq8fun(x,data)
% quadratic function of the form f(x)=gam+c'*x+0.5*(A*x-b)'*D*(A*x-b) to
% be minimized in minq8
%
% Input:
% x         vector of length n where the function is to be evaluated 
% data      data structure containing the function parameters:
% data.gam  gam in the function below (scalar)
% data.A    matrix A above (of size m times n)
% data.b    vector of length m (b in the above formula)
% data.D    vector of length m (D=diag(data.D) in the above formula) 
%
% Output:
% f     function value (scalar)
% g     gradient (vector of length n)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% minq8.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,f,g,nit,ier] = minq8(data,xl,xu,x,maxstep,tol,prt)
% minimization of f(x)=gam+c'*x+0.5*(A*x-b)'*diag(D)*(A*x-b) on the box
% [xu,xl], where gam, c, A, b and D are contained in the data structure
% data
% 
% Input:
% data     data structure containing:
% data.gam scalar
% data.c   vector of length n
% data.A   mxn matrix
% data.b   vector of length m
% data.D   vector of length m
% xl, xu   box bounds (vectors of length n, infinite entries allowed)
% x        starting point (default: absolutely smallest point in the 
%          box)
% maxit    limit on the number of iterations (default: n)
% tol      the algorithm stops if (fold-f)/max([abs(fold) abs(f) delta3])
%          <=tol (default: 1.e-8)
% prt      printing flag (default: 0)
%          = 0 no printing
%          ~= 0 prints intermediate function values
%
% Output:
% x        best point obtained
% f        corresponding function value
% g        corresponding gradient
% nit      number of iterations that have been carried out
% ier      error flag
%          = 0 regular completion
%          = 1 function is unbounded below
% Calls the following subprograms (directly or indirectly):
% fixbounds.m
% freebounds.m
% minq8fun.m
% qls.m
% redinact.m
% reductionstep.m
% submatrix.m
% subspacestep.m
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% minq8.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,f,g,nit,ier] = minq8(data,xl,xu,x,maxstep,tol,prt)
% minimization of f(x)=gam+c'*x+0.5*(A*x-b)'*diag(D)*(A*x-b) on the box
% [xu,xl], where gam, c, A, b and D are contained in the data structure
% data
% 
% Input:
% data     data structure containing:
% data.gam scalar
% data.c   vector of length n
% data.A   mxn matrix
% data.b   vector of length m
% data.D   vector of length m
% xl, xu   box bounds (vectors of length n, infinite entries allowed)
% x        starting point (default: absolutely smallest point in the 
%          box)
% maxit    limit on the number of iterations (default: n)
% tol      the algorithm stops if (fold-f)/max([abs(fold) abs(f) delta3])
%          <=tol (default: 1.e-8)
% prt      printing flag (default: 0)
%          = 0 no printing
%          ~= 0 prints intermediate function values
%
% Output:
% x        best point obtained
% f        corresponding function value
% g        corresponding gradient
% nit      number of iterations that have been carried out
% ier      error flag
%          = 0 regular completion
%          = 1 function is unbounded below
% Calls the following subprograms (directly or indirectly):
% fixbounds.m
% freebounds.m
% minq8fun.m
% qls.m
% redinact.m
% reductionstep.m
% submatrix.m
% subspacestep.m
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% qls.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,f,g,ier] = qls(x,f,g,p,xl,xu,data)
% quadratic line search
% minimizes the quadratic function 
% q(y)=gam+c'*y+0.5*(A*y-b)'*D*(A*y-b)
% for y=x+alp*p in [xl,xu]
%
% Input: 
% x        starting point
% f        its function value
% g        its gradient
% p        search direction
% xl, xu   box bounds
% data     data structure containing:
% data.gam scalar (= gam in q(y))
% data.c   vector of length n (= c in q(y))
% data.A   mxn matrix (= A in q(y))
% data.b   vector of length m (= b in q(y))
% data.D   vector of length m (diag(data.D) = D in q(y))
%
% Output:
% x        minimizer of the line search
% f        its function value
% g        its gradient
% ier      error flag
%          = 0 regular completion
%          = 1 function is unbounded below
% 
% Calls the following subprogram:
% minq8fun.m
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% redinact.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [i,al,au] = redinact(x,g,d,xl,xu,inact)
% computes the reduced inactive and extended active sets of a point 
% 
% Input:
% x       point for which these sets are to be computed  
% g       corresponding gradient
% d       vector of length n, = 0.5*diag(G), G Hessian
% xl, xu  box bounds (vectors of length n, infinite entries allowed)
% inact   vector pointing to the inactive variables of x
%
% Output:
% i       vector of reduced inactive variables of x
% al      indices from inact belonging to the extended lower active set
% au      indices from inact belonging to the extended upper active set
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% reductionstep.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,f,g,al,au,i,ier] = reductionstep(x,f,xl,xu,data,al,au,i)
% reduces the number of active variables
% 
% Input:
% x          starting point (vector of length n)
% f          its function value
% xl, xu     box bounds (vectors of length n, infinite entries allowed)
% data       data structure containing:
% data.gam   scalar
% data.c     vector of length n
% data.A     mxn matrix
% data.b     vector of length m
% data.D     vector of length m
% al         vector of indices that are predicted to be active at xl
% au         vector of indices that are predicted to be active at xu
% i          vector of predicted inactive indices
%
% Output:
% x          point with an increased number of activities
% f          its function value
% g          its gradient
% al, au, i  updated vectors of (in)active indices 
% ier        error flag
%            = 0 regular completion
%            = 1 function is unbounded below
% 
% Calls the following subprograms:
% minq8fun.m
% submatrix.m
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% runminq8.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab script for applying MINQ8
% - to a newly generated sparse problem (and store a .mat file),
% - to a problem from a .mat file, or
% - to one of the test functions from the CUTEr test set
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% runminq8sep.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generates a separable quadratic program as described in Section 5.3
% (test set), stores the input data and solves it by solving the dual 
% program with MINQ8 or solve such a problem by loading it from a .mat
% file
%
% Calls minq8sep.m and its subprogram
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% submatrix.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [i,j,C] = submatrix(A)
% determines index sets i and j such that A(i,j) is nonsingular and
% computes the inverse C of A(i,j)
% 
% Input:
% A  m times n matrix
% Output:
% i, j  vectors of length r such that A(i,j) is nonsingular
% C     inverse of A(i,j)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% subspacestep.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,f,g,ier] = subspacestep(x,f,g,xl,xu,data,al,au,i)
% makes a step in a subspace
%
% Input:
% x        starting point (vector of length n)
% f        its function value
% g        its gradient
% xl, xu   box bounds (vectors of length n, infinite entries allowed)
% data     data structure containing:
% data.gam scalar
% data.c   vector of length n
% data.A   mxn matrix
% data.b   vector of length m
% data.D   vector of length m
% data.G   Hessian, = data.A'*diag(data.D)*data.A (nxn matrix)
% al       vector of indices that are predicted active at xl
% au       vector of indices that are predicted active at xu
% i        vector of predicted inactive indices
%
% Output:
% x        current point
% f        its function value
% g        its gradient
% ier      error flag
%          = 0 regular completion
%          = 1 function is unbounded below
% 
% Calls the following subprograms (directly or indirectly):
% minq8fun.m
% qls.m
%




