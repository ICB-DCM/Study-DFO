
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void J_rafmekerk_laplace_standard(realtype *J, const realtype t, const realtype *x, const double *p, const double *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  J[0+0*3] = -p[0]-(p[1]*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0)))/(x[2]/p[6]+1.0);
  J[0+2*3] = (p[1]*1.0/pow(x[2]/p[6]+1.0,2.0)*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0))/p[6];
  J[1+0*3] = -(p[3]*(x[1]-1.0))/(k[0]/p[10]+1.0);
  J[1+1*3] = -p[2]-(p[3]*x[0])/(k[0]/p[10]+1.0);
  J[2+1*3] = -(p[5]*(x[2]-1.0))/(k[1]/p[11]+1.0);
  J[2+2*3] = -p[4]-(p[5]*x[1])/(k[1]/p[11]+1.0);
}

