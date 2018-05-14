
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dJydsigma_jakstat_laplace_hierarchical_adjoint_offsets(double *dJydsigma, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  dJydsigma[0+0*1] = 1.0/sigmay[0]-fabs(my[0]-y[0])*1.0/pow(fabs(sigmay[0]),2.0)*((sigmay[0]/fabs(sigmay[0])));
    break;
    case 1:
  dJydsigma[0+1*1] = 1.0/sigmay[1]-fabs(my[1]-y[1])*1.0/pow(fabs(sigmay[1]),2.0)*((sigmay[1]/fabs(sigmay[1])));
    break;
    case 2:
  dJydsigma[0+2*1] = 1.0/sigmay[2]-fabs(my[2]-y[2])*1.0/pow(fabs(sigmay[2]),2.0)*((sigmay[2]/fabs(sigmay[2])));
    break;
}
}

