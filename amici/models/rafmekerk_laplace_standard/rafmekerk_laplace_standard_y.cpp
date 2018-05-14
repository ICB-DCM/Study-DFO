
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void y_rafmekerk_laplace_standard(double *y, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  y[0] = x[1]*p[12];
  y[1] = x[2]*p[13];
  y[2] = x[1]*p[14];
  y[3] = x[2]*p[15];
  y[4] = x[1]*p[16];
  y[5] = x[2]*p[17];
  y[6] = x[1]*p[18];
  y[7] = x[2]*p[19];
}

