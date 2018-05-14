
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void Jy_rafmekerk_laplace_hierarchical_noreps_adjoint(double *nllh, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  nllh[0] = amici::log(sigmay[0]*2.0)+fabs(my[0]-y[0])/fabs(sigmay[0]);
    break;
    case 1:
  nllh[0] = amici::log(sigmay[1]*2.0)+fabs(my[1]-y[1])/fabs(sigmay[1]);
    break;
    case 2:
  nllh[0] = amici::log(sigmay[2]*2.0)+fabs(my[2]-y[2])/fabs(sigmay[2]);
    break;
    case 3:
  nllh[0] = amici::log(sigmay[3]*2.0)+fabs(my[3]-y[3])/fabs(sigmay[3]);
    break;
    case 4:
  nllh[0] = amici::log(sigmay[4]*2.0)+fabs(my[4]-y[4])/fabs(sigmay[4]);
    break;
    case 5:
  nllh[0] = amici::log(sigmay[5]*2.0)+fabs(my[5]-y[5])/fabs(sigmay[5]);
    break;
    case 6:
  nllh[0] = amici::log(sigmay[6]*2.0)+fabs(my[6]-y[6])/fabs(sigmay[6]);
    break;
    case 7:
  nllh[0] = amici::log(sigmay[7]*2.0)+fabs(my[7]-y[7])/fabs(sigmay[7]);
    break;
}
}

