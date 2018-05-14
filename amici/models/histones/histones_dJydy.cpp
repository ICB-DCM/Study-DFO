
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dJydy_histones(double *dJydy, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  dJydy[0+0*1] = 1.0/(sigmay[0]*sigmay[0])*(my[0]*2.0-y[0]*2.0)*-5.0E-1;
    break;
    case 1:
  dJydy[0+1*1] = 1.0/(sigmay[1]*sigmay[1])*(my[1]*2.0-y[1]*2.0)*-5.0E-1;
    break;
    case 2:
  dJydy[0+2*1] = 1.0/(sigmay[2]*sigmay[2])*(my[2]*2.0-y[2]*2.0)*-5.0E-1;
    break;
    case 3:
  dJydy[0+3*1] = 1.0/(sigmay[3]*sigmay[3])*(my[3]*2.0-y[3]*2.0)*-5.0E-1;
    break;
    case 4:
  dJydy[0+4*1] = 1.0/(sigmay[4]*sigmay[4])*(my[4]*2.0-y[4]*2.0)*-5.0E-1;
    break;
    case 5:
  dJydy[0+5*1] = 1.0/(sigmay[5]*sigmay[5])*(my[5]*2.0-y[5]*2.0)*-5.0E-1;
    break;
    case 6:
  dJydy[0+6*1] = 1.0/(sigmay[6]*sigmay[6])*(my[6]*2.0-y[6]*2.0)*-5.0E-1;
    break;
    case 7:
  dJydy[0+7*1] = 1.0/(sigmay[7]*sigmay[7])*(my[7]*2.0-y[7]*2.0)*-5.0E-1;
    break;
    case 8:
  dJydy[0+8*1] = 1.0/(sigmay[8]*sigmay[8])*(my[8]*2.0-y[8]*2.0)*-5.0E-1;
    break;
    case 9:
  dJydy[0+9*1] = 1.0/(sigmay[9]*sigmay[9])*(my[9]*2.0-y[9]*2.0)*-5.0E-1;
    break;
    case 10:
  dJydy[0+10*1] = 1.0/(sigmay[10]*sigmay[10])*(my[10]*2.0-y[10]*2.0)*-5.0E-1;
    break;
    case 11:
  dJydy[0+11*1] = 1.0/(sigmay[11]*sigmay[11])*(my[11]*2.0-y[11]*2.0)*-5.0E-1;
    break;
    case 12:
  dJydy[0+12*1] = 1.0/(sigmay[12]*sigmay[12])*(my[12]*2.0-y[12]*2.0)*-5.0E-1;
    break;
    case 13:
  dJydy[0+13*1] = 1.0/(sigmay[13]*sigmay[13])*(my[13]*2.0-y[13]*2.0)*-5.0E-1;
    break;
    case 14:
  dJydy[0+14*1] = 1.0/(sigmay[14]*sigmay[14])*(my[14]*2.0-y[14]*2.0)*-5.0E-1;
    break;
}
}

