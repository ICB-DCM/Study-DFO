
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void xBdot_hopfbifurcation(realtype *xBdot, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *w, const realtype *dwdx) {
  xBdot[0] = -p[3]*xB[2]+xB[0]*(-p[0]+p[3]+p[1]*x[1]);
  xBdot[1] = p[2]*xB[1]+p[1]*x[0]*xB[0];
  xBdot[2] = -xB[1]*dwdx[0]+xB[2]*dwdx[0];
}

