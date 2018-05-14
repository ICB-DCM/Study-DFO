
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void Jv_hopfbifurcation(realtype *Jv, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *v, const realtype *w, const realtype *dwdx) {
  Jv[0] = -v[0]*(-p[0]+p[3]+p[1]*x[1])-p[1]*v[1]*x[0];
  Jv[1] = -p[2]*v[1]+v[2]*dwdx[0];
  Jv[2] = p[3]*v[0]-v[2]*dwdx[0];
}

