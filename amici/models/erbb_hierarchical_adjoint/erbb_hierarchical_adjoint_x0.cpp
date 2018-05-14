
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void x0_erbb_hierarchical_adjoint(realtype *x0, const realtype t, const realtype *p, const realtype *k) {
  x0[13] = 4.62E5;
  x0[15] = 6.23E3;
  x0[17] = 7.94E2;
  x0[34] = 1.2E9;
  x0[72] = 4.49873E3;
  x0[276] = 5.34751E5;
  x0[289] = 1.26491E3;
  x0[299] = 5.80952E4;
  x0[304] = 1.1E6;
  x0[311] = 7.11312E4;
  x0[317] = 8.8914E7;
  x0[318] = 5.0E4;
  x0[323] = 3.02E6;
  x0[330] = 1.2448E5;
  x0[335] = 6.95E5;
  x0[344] = 1.68702E4;
  x0[367] = 3.55656E7;
  x0[394] = 9.05E5;
  x0[398] = 3.00416E8;
  x0[403] = 4.5E5;
  x0[406] = 7.0E4;
  x0[415] = 1.08E6;
  x0[423] = 2.21359E3;
  x0[424] = 3.93639E5;
  x0[426] = 5.61009E4;
  x0[428] = 9.48683E4;
  x0[430] = 1.0E6;
}

