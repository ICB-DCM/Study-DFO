
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void xdot_hopfbifurcation(realtype *xdot, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w) {
  xdot[0] = x[0]*(p[0]-p[3])-p[1]*x[0]*x[1];
  xdot[1] = w[0]-p[2]*x[1];
  xdot[2] = -w[0]+p[3]*x[0];
}

