
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void sigma_y_histonesPre(double *sigmay, const realtype t, const realtype *p, const realtype *k) {
  sigmay[0] = p[45];
  sigmay[1] = p[45];
  sigmay[2] = p[45];
  sigmay[3] = p[45];
  sigmay[4] = p[45];
  sigmay[5] = p[45];
  sigmay[6] = p[45];
  sigmay[7] = p[45];
  sigmay[8] = p[45];
  sigmay[9] = p[45];
  sigmay[10] = p[45];
  sigmay[11] = p[45];
  sigmay[12] = p[45];
  sigmay[13] = p[45];
  sigmay[14] = p[45];
}

