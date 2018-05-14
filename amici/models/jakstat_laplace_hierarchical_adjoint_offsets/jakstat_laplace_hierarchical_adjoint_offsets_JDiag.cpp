
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void JDiag_jakstat_laplace_hierarchical_adjoint_offsets(realtype *JDiag, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  JDiag[0+0*9] = -p[0]*w[0];
  JDiag[1+0*9] = p[1]*dwdx[0]*-2.0;
  JDiag[2+0*9] = -p[2];
  JDiag[3+0*9] = -p[3];
  JDiag[4+0*9] = -p[3];
  JDiag[5+0*9] = -p[3];
  JDiag[6+0*9] = -p[3];
  JDiag[7+0*9] = -p[3];
  JDiag[8+0*9] = -p[3];
}

