
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dJydy_rafmekerk_laplace_hierarchical_noreps_adjoint(double *dJydy, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  dJydy[0+0*1] = -(((my[0]-y[0])/fabs(my[0]-y[0])))/fabs(sigmay[0]);
    break;
    case 1:
  dJydy[0+1*1] = -(((my[1]-y[1])/fabs(my[1]-y[1])))/fabs(sigmay[1]);
    break;
    case 2:
  dJydy[0+2*1] = -(((my[2]-y[2])/fabs(my[2]-y[2])))/fabs(sigmay[2]);
    break;
    case 3:
  dJydy[0+3*1] = -(((my[3]-y[3])/fabs(my[3]-y[3])))/fabs(sigmay[3]);
    break;
    case 4:
  dJydy[0+4*1] = -(((my[4]-y[4])/fabs(my[4]-y[4])))/fabs(sigmay[4]);
    break;
    case 5:
  dJydy[0+5*1] = -(((my[5]-y[5])/fabs(my[5]-y[5])))/fabs(sigmay[5]);
    break;
    case 6:
  dJydy[0+6*1] = -(((my[6]-y[6])/fabs(my[6]-y[6])))/fabs(sigmay[6]);
    break;
    case 7:
  dJydy[0+7*1] = -(((my[7]-y[7])/fabs(my[7]-y[7])))/fabs(sigmay[7]);
    break;
}
}

