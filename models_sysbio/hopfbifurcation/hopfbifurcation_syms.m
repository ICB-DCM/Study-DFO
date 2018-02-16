% Compile this with AMICI from http://icb-dcm.github.io/AMICI/ 
% to get a simulate_ODE_M4 file which can be
% executed in MATLAB and runs C-Code for ODE integration.
%
% Written by Benjamin Ballnus (2016)

function model = hopfbifurcation_syms()
             
% CVODES OPTIONS
model.param = 'lin';

% STATES
syms X1 X2 X3
model.sym.x = [X1,X2,X3];

% PARAMETERS
syms p1 p2 p3 p4 p5 p6 p7 p8 sigma1 sigma2 sigma3
model.sym.p = [p1,p2,p3,p4,p5,p6,p7,p8,sigma1,sigma2,sigma3];

% CONSTANTS
model.sym.k = [];

% SYSTEM EQUATIONS
syms t
model.sym.xdot = sym(zeros(size(model.sym.x)));

model.sym.xdot(1) = ( p1 - p4 ) * X1 - p2 * X1 * X2;
model.sym.xdot(2) = - p3 * X2 + p5 * X3;
model.sym.xdot(3) = p4 * X1 - p5 * X3;

% INITIAL CONDITIONS
model.sym.x0 = sym(zeros(size(model.sym.x)));

model.sym.x0(1) = p6;
model.sym.x0(2) = p7;
model.sym.x0(3) = p8;

% OBSERVABLES
model.sym.y = model.sym.x;

% UNCERTAINTIES

model.sym.sigma_y = sym(size(model.sym.y));

model.sym.sigma_y(1) = sigma1;
model.sym.sigma_y(2) = sigma2;
model.sym.sigma_y(3) = sigma3;
                                         
