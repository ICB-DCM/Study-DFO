
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void J_hopfbifurcation(realtype *J, const realtype t, const realtype *x, const double *p, const double *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  J[0+0*3] = p[0]-p[3]-p[1]*x[1];
  J[0+1*3] = -p[1]*x[0];
  J[1+1*3] = -p[2];
  J[1+2*3] = dwdx[0];
  J[2+0*3] = p[3];
  J[2+2*3] = -dwdx[0];
}

