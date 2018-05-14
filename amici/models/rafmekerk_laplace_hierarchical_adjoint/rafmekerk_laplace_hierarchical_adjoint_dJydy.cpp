
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dJydy_rafmekerk_laplace_hierarchical_adjoint(double *dJydy, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  dJydy[0+0*1] = -(((my[0]-y[0])/fabs(my[0]-y[0])))/fabs(sigmay[0]);
    break;
    case 1:
  dJydy[0+1*1] = -(((my[1]-y[1])/fabs(my[1]-y[1])))/fabs(sigmay[1]);
    break;
}
}

