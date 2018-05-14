
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void JDiag_rafmekerk_hierarchical_noreps_forward(realtype *JDiag, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  JDiag[0+0*3] = -p[0]-(p[1]*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0)))/(x[2]/p[6]+1.0);
  JDiag[1+0*3] = -p[2]-(p[3]*x[0])/(k[0]/p[10]+1.0);
  JDiag[2+0*3] = -p[4]-(p[5]*x[1])/(k[1]/p[11]+1.0);
}

