addpath('../models_testfunction/');
addpath(genpath('../algorithms/mcs'));

fcn = 'mcsFunHandleWrap';
dim = 10;
smax = 5*dim+10;
maxFunEvals = 2000;

[x,f,p,q,ncall] = mcs(fcn,@TF.f_ackley,-6*ones(dim,1),6*ones(dim,1),0,smax,maxFunEvals)