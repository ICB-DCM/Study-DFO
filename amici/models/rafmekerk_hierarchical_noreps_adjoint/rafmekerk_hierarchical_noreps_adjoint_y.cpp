
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void y_rafmekerk_hierarchical_noreps_adjoint(double *y, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  y[0] = k[2]*x[1];
  y[1] = k[3]*x[2];
  y[2] = k[4]*x[1];
  y[3] = k[5]*x[2];
  y[4] = k[6]*x[1];
  y[5] = k[7]*x[2];
  y[6] = k[8]*x[1];
  y[7] = k[9]*x[2];
}

