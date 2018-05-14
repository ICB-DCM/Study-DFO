
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydx_rafmekerk_laplace_hierarchical_noreps_adjoint(double *dydx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  dydx[0+1*8] = k[2];
  dydx[1+2*8] = k[3];
  dydx[2+1*8] = k[4];
  dydx[3+2*8] = k[5];
  dydx[4+1*8] = k[6];
  dydx[5+2*8] = k[7];
  dydx[6+1*8] = k[8];
  dydx[7+2*8] = k[9];
}

