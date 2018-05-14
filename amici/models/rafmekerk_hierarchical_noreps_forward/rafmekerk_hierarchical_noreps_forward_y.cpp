
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void y_rafmekerk_hierarchical_noreps_forward(double *y, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  y[0] = x[1];
  y[1] = x[2];
  y[2] = x[1];
  y[3] = x[2];
  y[4] = x[1];
  y[5] = x[2];
  y[6] = x[1];
  y[7] = x[2];
}

