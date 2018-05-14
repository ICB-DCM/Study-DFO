
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void sigma_y_rafmekerk_laplace_standard(double *sigmay, const realtype t, const realtype *p, const realtype *k) {
  sigmay[0] = p[20];
  sigmay[1] = p[21];
  sigmay[2] = p[22];
  sigmay[3] = p[23];
  sigmay[4] = p[24];
  sigmay[5] = p[25];
  sigmay[6] = p[26];
  sigmay[7] = p[27];
}

