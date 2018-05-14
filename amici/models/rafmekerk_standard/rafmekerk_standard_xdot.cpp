
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void xdot_rafmekerk_standard(realtype *xdot, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w) {
  xdot[0] = -p[0]*x[0]-(p[1]*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0))/(x[2]/p[6]+1.0);
  xdot[1] = -p[2]*x[1]-(p[3]*x[0]*(x[1]-1.0))/(k[0]/p[10]+1.0);
  xdot[2] = -p[4]*x[2]-(p[5]*x[1]*(x[2]-1.0))/(k[1]/p[11]+1.0);
}

