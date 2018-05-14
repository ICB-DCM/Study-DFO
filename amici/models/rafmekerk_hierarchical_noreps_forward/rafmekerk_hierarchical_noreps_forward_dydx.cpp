
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydx_rafmekerk_hierarchical_noreps_forward(double *dydx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  dydx[0+1*8] = 1.0;
  dydx[1+2*8] = 1.0;
  dydx[2+1*8] = 1.0;
  dydx[3+2*8] = 1.0;
  dydx[4+1*8] = 1.0;
  dydx[5+2*8] = 1.0;
  dydx[6+1*8] = 1.0;
  dydx[7+2*8] = 1.0;
}

