
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydx_jakstat_hierarchical_adjoint_offsets(double *dydx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  dydx[0+1*3] = k[4]/p[4];
  dydx[0+2*3] = (k[4]*2.0)/p[4];
  dydx[1+0*3] = k[5]/p[4];
  dydx[1+1*3] = k[5]/p[4];
  dydx[1+2*3] = (k[5]*2.0)/p[4];
}

