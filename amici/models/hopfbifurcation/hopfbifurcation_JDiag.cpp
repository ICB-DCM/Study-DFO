
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void JDiag_hopfbifurcation(realtype *JDiag, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  JDiag[0+0*3] = p[0]-p[3]-p[1]*x[1];
  JDiag[1+0*3] = -p[2];
  JDiag[2+0*3] = -dwdx[0];
}

