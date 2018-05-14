
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydx_histonesPre(double *dydx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  dydx[0+0*15] = 1.0;
  dydx[1+1*15] = 1.0;
  dydx[2+2*15] = 1.0;
  dydx[3+3*15] = 1.0;
  dydx[4+4*15] = 1.0;
  dydx[5+5*15] = 1.0;
  dydx[6+6*15] = 1.0;
  dydx[7+7*15] = 1.0;
  dydx[8+8*15] = 1.0;
  dydx[9+9*15] = 1.0;
  dydx[10+10*15] = 1.0;
  dydx[11+11*15] = 1.0;
  dydx[12+12*15] = 1.0;
  dydx[13+13*15] = 1.0;
  dydx[14+14*15] = 1.0;
}

