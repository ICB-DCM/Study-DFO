

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% MINQ - bound constrained quadratic programming            %%%%%%
%%%%%%%        using rank 1 modifications                         %%%%%%
%%%%%%% source: http://solon.cma.univie.ac.at/~neum/software/minq %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% minimizes an affine quadratic form subject to simple bounds,
% using coordinate searches and reduced subspace minimizations
%    min    fct= gamma + c^T x + 0.5 x^T G x 
%    s.t.   x in [xu,xo]    % xu<=xo is assumed
% where G is symmetric n x n, (not necessarily definite)
%
% minq.m can also be used for definite QP 
% since the dual is simply constrained; e.g. if primal is
% min f=c^Tx + 0.5*epsi*x^Tx 
% s.t. Ax>=b
% then the dual is 
% min d=||A^Ty-c||^2-2epsi*b^Ty (generally with singular Hessian)
% s.t. y>=0
% and x is recovered as x=1/epsi*(A^Ty-c)
% any feasible dual point gives a lower bound -d/(2epsi) for f
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% minq.m		bound constrained QP solver
% minqsub.m		patch for minq.m containing the subspace search
% 
% minq.m calls the following subroutines:
% getalp.m		exact quadratic line search
% ldldown.m		LDL^T factorization downdate
% ldlrk1.m		LDL^T factorization rank 1 change
% ldlup.m		LDL^T factorization update
% ldltest.m		LDL^T factorization update
% pr01.m		print characteristic vecor of activities
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% minq.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x,fct,ier]=minq(gamma,c,G,xu,xo,prt,xx);
% minimizes an affine quadratic form subject to simple bounds,
% using coordinate searches and reduced subspace minimizations
%    min    fct= gamma + c^T x + 0.5 x^T G x 
%    s.t.   x in [xu,xo]    % xu<=xo is assumed
% where G is symmetric n x n, (not necessarily definite)
%
% prt	printlevel
% xx	guess (optional)
% x	minimizer (but unbounded direction if ier=1)
% fct	optimal function value
% ier	0  (local minimizer found)
% 	1  (unbounded below)
% 	99 (maxit exceeded)
%
% [x,fct,ier,nsub]=minq(prt)	... debug mode with old data
%
