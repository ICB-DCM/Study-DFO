
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydx_rafmekerk_hierarchical_forward(double *dydx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  dydx[0+1*2] = 1.0;
  dydx[1+2*2] = 1.0;
}

