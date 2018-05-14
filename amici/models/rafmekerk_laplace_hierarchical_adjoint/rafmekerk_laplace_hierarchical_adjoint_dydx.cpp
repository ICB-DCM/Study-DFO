
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydx_rafmekerk_laplace_hierarchical_adjoint(double *dydx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  dydx[0+1*2] = k[2];
  dydx[1+2*2] = k[3];
}

