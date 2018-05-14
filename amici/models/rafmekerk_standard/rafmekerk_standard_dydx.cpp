
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydx_rafmekerk_standard(double *dydx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  dydx[0+1*8] = p[12];
  dydx[1+2*8] = p[13];
  dydx[2+1*8] = p[14];
  dydx[3+2*8] = p[15];
  dydx[4+1*8] = p[16];
  dydx[5+2*8] = p[17];
  dydx[6+1*8] = p[18];
  dydx[7+2*8] = p[19];
}

