
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void Jv_rafmekerk_laplace_standard(realtype *Jv, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *v, const realtype *w, const realtype *dwdx) {
  Jv[0] = -v[0]*(p[0]+(p[1]*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0)))/(x[2]/p[6]+1.0))+(p[1]*v[2]*1.0/pow(x[2]/p[6]+1.0,2.0)*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0))/p[6];
  Jv[1] = -v[1]*(p[2]+(p[3]*x[0])/(k[0]/p[10]+1.0))-(p[3]*v[0]*(x[1]-1.0))/(k[0]/p[10]+1.0);
  Jv[2] = -v[2]*(p[4]+(p[5]*x[1])/(k[1]/p[11]+1.0))-(p[5]*v[1]*(x[2]-1.0))/(k[1]/p[11]+1.0);
}

