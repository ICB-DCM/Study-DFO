% Compile this with AMICI from http://icb-dcm.github.io/AMICI/ 
% to get a simulate_ODE_M6 file which can be
% executed in MATLAB and runs C-Code for ODE integration.
%
% Written by Benjamin Ballnus (2016)

function model = ODE_M6()

% STATES

syms X1 X2 X3
x = [X1,X2,X3];

% PARAMETERS

syms p1 p2 p3 p4 p5 p6
p = [p1,p2,p3,p4,p5,p6];

% SYSTEM EQUATIONS

xdot = sym(zeros(size(x)));

xdot(1) = p1 * (X2-X1);
xdot(2) = X1 * (p3 - X3) - X2;
xdot(3) = X1 * X2 - p2 * X3;

% INITIAL CONDITIONS

x0 = sym(zeros(size(x)));

x0(1) = p4;
x0(2) = p5;
x0(3) = p6;

% OBSERVABLES

y = x;

% SYSTEM STRUCT

model.sym.x = x;
model.sym.xdot = xdot;
model.sym.p = p;
model.sym.k = [];
model.sym.x0 = x0;
model.sym.y = y;
                                         
