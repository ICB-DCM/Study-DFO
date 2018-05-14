
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydx_jakstat_standard(double *dydx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  dydx[0+1*3] = p[13]/p[4];
  dydx[0+2*3] = (p[13]*2.0)/p[4];
  dydx[1+0*3] = p[12]/p[4];
  dydx[1+1*3] = p[12]/p[4];
  dydx[1+2*3] = (p[12]*2.0)/p[4];
}

