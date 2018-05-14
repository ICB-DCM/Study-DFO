
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void JvB_hopfbifurcation(realtype *JvB, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *vB, const realtype *w, const realtype *dwdx) {
  JvB[0] = -p[3]*vB[2]+vB[0]*(-p[0]+p[3]+p[1]*x[1]);
  JvB[1] = p[2]*vB[1]+p[1]*x[0]*vB[0];
  JvB[2] = -vB[1]*dwdx[0]+vB[2]*dwdx[0];
}

