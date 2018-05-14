
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void y_rafmekerk_laplace_hierarchical_adjoint(double *y, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  y[0] = k[2]*x[1];
  y[1] = k[3]*x[2];
}

