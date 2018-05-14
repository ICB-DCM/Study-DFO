
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void JB_rafmekerk_laplace_hierarchical_noreps_adjoint(realtype *JB, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *w, const realtype *dwdx) {
  JB[0+0*3] = p[0]+(p[1]*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0)))/(x[2]/p[6]+1.0);
  JB[0+1*3] = (p[3]*(x[1]-1.0))/(k[0]/p[10]+1.0);
  JB[1+1*3] = p[2]+(p[3]*x[0])/(k[0]/p[10]+1.0);
  JB[1+2*3] = (p[5]*(x[2]-1.0))/(k[1]/p[11]+1.0);
  JB[2+0*3] = -(p[1]*1.0/pow(x[2]/p[6]+1.0,2.0)*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0))/p[6];
  JB[2+2*3] = p[4]+(p[5]*x[1])/(k[1]/p[11]+1.0);
}

