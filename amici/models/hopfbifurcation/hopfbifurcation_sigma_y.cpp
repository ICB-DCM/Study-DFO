
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void sigma_y_hopfbifurcation(double *sigmay, const realtype t, const realtype *p, const realtype *k) {
  sigmay[0] = p[8];
  sigmay[1] = p[9];
  sigmay[2] = p[10];
}

