function model = Bachmann_JAKSTAT_SHP1oe_syms()

syms t
model.param = 'log10';

%% PARAMETERS
syms CISEqc CISEqcOE CISInh CISRNADelay  CISRNATurn CISTurn
syms EpoRActJAK2 EpoRCISInh EpoRCISRemove JAK2ActEpo JAK2EpoRDeaSHP1 SHP1ActEpoR
syms SHP1Dea SHP1ProOE SOCS3Eqc SOCS3EqcOE SOCS3Inh SOCS3RNADelay 
syms SOCS3RNATurn SOCS3Turn STAT5ActEpoR STAT5ActJAK2 STAT5Exp STAT5Imp
syms init_EpoRJAK2 init_SHP1 init_STAT5

model.sym.p = [CISEqc
CISEqcOE
CISInh
CISRNADelay
CISRNATurn
CISTurn
EpoRActJAK2
EpoRCISInh
EpoRCISRemove
JAK2ActEpo
JAK2EpoRDeaSHP1
SHP1ActEpoR
SHP1Dea
SHP1ProOE
SOCS3Eqc
SOCS3EqcOE
SOCS3Inh
SOCS3RNADelay
SOCS3RNATurn
SOCS3Turn
STAT5ActEpoR
STAT5ActJAK2
STAT5Exp
STAT5Imp
init_EpoRJAK2
init_SHP1
init_STAT5];

%% INPUT AND CONSTANTS
syms ActD CISoe SOCS3oe SHP1oe Epo nuc cyt

cyt = 0.4;
nuc = 0.275;

model.sym.k = [ActD CISoe SOCS3oe SHP1oe Epo];

%% STATES
syms EpoRJAK2 EpoRpJAK2 p1EpoRpJAK2 p2EpoRpJAK2 p12EpoRpJAK2 EpoRJAK2_CIS
syms SHP1 SHP1Act STAT5 pSTAT5 npSTAT5 CISnRNA1 CISnRNA2
syms CISnRNA3 CISnRNA4 CISnRNA5 CISRNA CIS
syms SOCS3nRNA1 SOCS3nRNA2 SOCS3nRNA3 SOCS3nRNA4 SOCS3nRNA5 SOCS3RNA SOCS3

model.sym.x = [EpoRJAK2;
EpoRpJAK2;
p1EpoRpJAK2;
p2EpoRpJAK2;
p12EpoRpJAK2;
EpoRJAK2_CIS;
SHP1;
SHP1Act;
STAT5;
pSTAT5;
npSTAT5;
CISnRNA1;
CISnRNA2;
CISnRNA3;
CISnRNA4;
CISnRNA5;
CISRNA;
CIS;
SOCS3nRNA1;
SOCS3nRNA2;
SOCS3nRNA3;
SOCS3nRNA4;
SOCS3nRNA5;
SOCS3RNA;
SOCS3];    




model.sym.xdot = [EpoRpJAK2*(JAK2EpoRDeaSHP1 / (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))))*SHP1Act + (JAK2EpoRDeaSHP1 / (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))))*SHP1Act*p12EpoRpJAK2 + (JAK2EpoRDeaSHP1 / (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))))*SHP1Act*p1EpoRpJAK2 + (JAK2EpoRDeaSHP1 / (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))))*SHP1Act*p2EpoRpJAK2 - (Epo*EpoRJAK2*JAK2ActEpo)/(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1) ;
 (Epo*EpoRJAK2*JAK2ActEpo)/(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1) - (EpoRpJAK2*EpoRActJAK2)/(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1) - (3*EpoRpJAK2*EpoRActJAK2)/((EpoRCISInh*EpoRJAK2_CIS + 1)*(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1)) - EpoRpJAK2*(JAK2EpoRDeaSHP1 / (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))))*SHP1Act ;
 (EpoRpJAK2*EpoRActJAK2)/(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1) - (JAK2EpoRDeaSHP1 / (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))))*SHP1Act*p1EpoRpJAK2 - (3*EpoRActJAK2*p1EpoRpJAK2)/((EpoRCISInh*EpoRJAK2_CIS + 1)*(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1)) ;
 (3*EpoRpJAK2*EpoRActJAK2)/((EpoRCISInh*EpoRJAK2_CIS + 1)*(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1)) - (EpoRActJAK2*p2EpoRpJAK2)/(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1) - (JAK2EpoRDeaSHP1 / (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))))*SHP1Act*p2EpoRpJAK2 ;
 (EpoRActJAK2*p2EpoRpJAK2)/(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1) - (JAK2EpoRDeaSHP1 / (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))))*SHP1Act*p12EpoRpJAK2 + (3*EpoRActJAK2*p1EpoRpJAK2)/((EpoRCISInh*EpoRJAK2_CIS + 1)*(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1)) ;
 -EpoRJAK2_CIS*(EpoRCISRemove / init_EpoRJAK2)*(p12EpoRpJAK2 + p1EpoRpJAK2) ;
 SHP1Dea*SHP1Act - SHP1*(SHP1ActEpoR / init_EpoRJAK2)*(EpoRpJAK2 + p12EpoRpJAK2 + p1EpoRpJAK2 + p2EpoRpJAK2) ;
 SHP1*(SHP1ActEpoR / init_EpoRJAK2)*(EpoRpJAK2 + p12EpoRpJAK2 + p1EpoRpJAK2 + p2EpoRpJAK2) - SHP1Dea*SHP1Act ;
 (STAT5Exp*npSTAT5*nuc)/cyt - (STAT5*(STAT5ActJAK2 / init_EpoRJAK2)*(EpoRpJAK2 + p12EpoRpJAK2 + p1EpoRpJAK2 + p2EpoRpJAK2))/(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1) - (STAT5*(STAT5ActEpoR / init_EpoRJAK2^2)*(p12EpoRpJAK2 + p1EpoRpJAK2)^2)/((CIS*(CISInh / CISEqc) + 1)*(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1)) ;
 (STAT5*(STAT5ActJAK2 / init_EpoRJAK2)*(EpoRpJAK2 + p12EpoRpJAK2 + p1EpoRpJAK2 + p2EpoRpJAK2))/(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1) - STAT5Imp*pSTAT5 + (STAT5*(STAT5ActEpoR / init_EpoRJAK2^2)*(p12EpoRpJAK2 + p1EpoRpJAK2)^2)/((CIS*(CISInh / CISEqc) + 1)*(SOCS3*(SOCS3Inh / SOCS3Eqc) + 1)) ;
 (STAT5Imp*cyt*pSTAT5)/nuc - STAT5Exp*npSTAT5 ;
 - CISnRNA1*CISRNADelay - (1 / init_STAT5)*CISRNATurn*npSTAT5*(ActD - 1) ;
 CISnRNA1*CISRNADelay - CISnRNA2*CISRNADelay ;
 CISnRNA2*CISRNADelay - CISnRNA3*CISRNADelay ;
 CISnRNA3*CISRNADelay - CISnRNA4*CISRNADelay ;
 CISnRNA4*CISRNADelay - CISnRNA5*CISRNADelay ;
 (CISnRNA5*CISRNADelay*nuc)/cyt - CISRNA*CISRNATurn ;
 CISRNA*CISEqc*CISTurn - CIS*CISTurn + CISoe*CISTurn*CISEqcOE * CISEqc ;
 - SOCS3nRNA1*SOCS3RNADelay - (1 / init_STAT5)*SOCS3RNATurn*npSTAT5*(ActD - 1) ;
 SOCS3nRNA1*SOCS3RNADelay - SOCS3nRNA2*SOCS3RNADelay ;
 SOCS3nRNA2*SOCS3RNADelay - SOCS3nRNA3*SOCS3RNADelay ;
 SOCS3nRNA3*SOCS3RNADelay - SOCS3nRNA4*SOCS3RNADelay ;
 SOCS3nRNA4*SOCS3RNADelay - SOCS3nRNA5*SOCS3RNADelay ;
 (SOCS3nRNA5*SOCS3RNADelay*nuc)/cyt - SOCS3RNA*SOCS3RNATurn ;
 SOCS3RNA*SOCS3Eqc*SOCS3Turn - SOCS3*SOCS3Turn + SOCS3oe*SOCS3Turn*SOCS3EqcOE * SOCS3Eqc] ;

model.sym.x0=sym(zeros(numel(model.sym.xdot),1));
model.sym.x0(1) = init_EpoRJAK2;
model.sym.x0(7) = (init_SHP1 * (1 + (SHP1oe * SHP1ProOE))); 
model.sym.x0(9) = init_STAT5;

%% OBSERVABLES
% 
% model.sym.y = [1 / init_EpoRJAK2 *  2 * (EpoRpJAK2 + p1EpoRpJAK2 + p2EpoRpJAK2 + p12EpoRpJAK2);
%  1 / init_EpoRJAK2 *  16 * (p1EpoRpJAK2 + p2EpoRpJAK2 + p12EpoRpJAK2);
%  1 / CISEqc / init_STAT5 * CIS;
%  1 / SOCS3Eqc / init_STAT5 * SOCS3;
%  1 / init_STAT5 * (STAT5+pSTAT5);
%  1 / init_STAT5 * pSTAT5;
%  STAT5;
%  SHP1 + SHP1Act;
%  CIS;
%  SOCS3;
%  100*pSTAT5/(pSTAT5+STAT5);
%  1 / init_STAT5 * SOCS3RNA;
%  1 / init_STAT5 * SOCS3RNA;
%  1 / init_STAT5 * SOCS3RNA;
%  1 / init_STAT5 * CISRNA;
%  1 / init_STAT5 * CISRNA;
%  1 / init_STAT5 * CISRNA;
%  1 / init_SHP1 * (SHP1 + SHP1Act) * (1 + (SHP1oe * SHP1ProOE));
%  1 / CISEqc / init_STAT5 * CIS;
%  1 / CISEqc / init_STAT5 * CIS];

model.sym.y = [1 / init_EpoRJAK2 *  2 * (EpoRpJAK2 + p1EpoRpJAK2 + p2EpoRpJAK2 + p12EpoRpJAK2);
 1 / init_EpoRJAK2 *  16 * (p1EpoRpJAK2 + p2EpoRpJAK2 + p12EpoRpJAK2);
 1 / CISEqc * CIS;
 1 / SOCS3Eqc * SOCS3;
 1 / init_STAT5 * (STAT5+pSTAT5);
 1 / init_STAT5 * pSTAT5;
 STAT5;
 SHP1 + SHP1Act;
 CIS;
 SOCS3;
 100*pSTAT5/(pSTAT5+STAT5);
 SOCS3RNA;
 SOCS3RNA;
 SOCS3RNA;
 CISRNA;
 CISRNA;
 CISRNA;
 1 / init_SHP1 * (SHP1 + SHP1Act) * (1 + (SHP1oe * SHP1ProOE));
 1 / CISEqc * CIS;
 1 / CISEqc * CIS];
%% SIGMA
model.sym.sigma_y = sym(ones(20,1));
