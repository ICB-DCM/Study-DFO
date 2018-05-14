
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void x0_hopfbifurcation(realtype *x0, const realtype t, const realtype *p, const realtype *k) {
  x0[0] = p[5];
  x0[1] = p[6];
  x0[2] = p[7];
}

