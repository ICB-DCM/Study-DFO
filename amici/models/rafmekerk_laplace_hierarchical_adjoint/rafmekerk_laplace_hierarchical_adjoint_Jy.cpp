
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void Jy_rafmekerk_laplace_hierarchical_adjoint(double *nllh, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  nllh[0] = amici::log(sigmay[0]*2.0)+fabs(my[0]-y[0])/fabs(sigmay[0]);
    break;
    case 1:
  nllh[0] = amici::log(sigmay[1]*2.0)+fabs(my[1]-y[1])/fabs(sigmay[1]);
    break;
}
}

