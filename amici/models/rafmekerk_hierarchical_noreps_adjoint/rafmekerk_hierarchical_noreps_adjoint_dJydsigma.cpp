
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dJydsigma_rafmekerk_hierarchical_noreps_adjoint(double *dJydsigma, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  dJydsigma[0+0*1] = 1.0/(sigmay[0]*sigmay[0]*sigmay[0])*pow(my[0]-y[0],2.0)*-1.0+1.0/sigmay[0];
    break;
    case 1:
  dJydsigma[0+1*1] = 1.0/(sigmay[1]*sigmay[1]*sigmay[1])*pow(my[1]-y[1],2.0)*-1.0+1.0/sigmay[1];
    break;
    case 2:
  dJydsigma[0+2*1] = 1.0/(sigmay[2]*sigmay[2]*sigmay[2])*pow(my[2]-y[2],2.0)*-1.0+1.0/sigmay[2];
    break;
    case 3:
  dJydsigma[0+3*1] = 1.0/(sigmay[3]*sigmay[3]*sigmay[3])*pow(my[3]-y[3],2.0)*-1.0+1.0/sigmay[3];
    break;
    case 4:
  dJydsigma[0+4*1] = 1.0/(sigmay[4]*sigmay[4]*sigmay[4])*pow(my[4]-y[4],2.0)*-1.0+1.0/sigmay[4];
    break;
    case 5:
  dJydsigma[0+5*1] = 1.0/(sigmay[5]*sigmay[5]*sigmay[5])*pow(my[5]-y[5],2.0)*-1.0+1.0/sigmay[5];
    break;
    case 6:
  dJydsigma[0+6*1] = 1.0/(sigmay[6]*sigmay[6]*sigmay[6])*pow(my[6]-y[6],2.0)*-1.0+1.0/sigmay[6];
    break;
    case 7:
  dJydsigma[0+7*1] = 1.0/(sigmay[7]*sigmay[7]*sigmay[7])*pow(my[7]-y[7],2.0)*-1.0+1.0/sigmay[7];
    break;
}
}

