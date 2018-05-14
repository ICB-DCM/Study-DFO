
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void Jy_histones(double *nllh, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  nllh[0] = amici::log((sigmay[0]*sigmay[0])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[0]*sigmay[0])*pow(my[0]-y[0],2.0)*5.0E-1;
    break;
    case 1:
  nllh[0] = amici::log((sigmay[1]*sigmay[1])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[1]*sigmay[1])*pow(my[1]-y[1],2.0)*5.0E-1;
    break;
    case 2:
  nllh[0] = amici::log((sigmay[2]*sigmay[2])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[2]*sigmay[2])*pow(my[2]-y[2],2.0)*5.0E-1;
    break;
    case 3:
  nllh[0] = amici::log((sigmay[3]*sigmay[3])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[3]*sigmay[3])*pow(my[3]-y[3],2.0)*5.0E-1;
    break;
    case 4:
  nllh[0] = amici::log((sigmay[4]*sigmay[4])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[4]*sigmay[4])*pow(my[4]-y[4],2.0)*5.0E-1;
    break;
    case 5:
  nllh[0] = amici::log((sigmay[5]*sigmay[5])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[5]*sigmay[5])*pow(my[5]-y[5],2.0)*5.0E-1;
    break;
    case 6:
  nllh[0] = amici::log((sigmay[6]*sigmay[6])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[6]*sigmay[6])*pow(my[6]-y[6],2.0)*5.0E-1;
    break;
    case 7:
  nllh[0] = amici::log((sigmay[7]*sigmay[7])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[7]*sigmay[7])*pow(my[7]-y[7],2.0)*5.0E-1;
    break;
    case 8:
  nllh[0] = amici::log((sigmay[8]*sigmay[8])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[8]*sigmay[8])*pow(my[8]-y[8],2.0)*5.0E-1;
    break;
    case 9:
  nllh[0] = amici::log((sigmay[9]*sigmay[9])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[9]*sigmay[9])*pow(my[9]-y[9],2.0)*5.0E-1;
    break;
    case 10:
  nllh[0] = amici::log((sigmay[10]*sigmay[10])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[10]*sigmay[10])*pow(my[10]-y[10],2.0)*5.0E-1;
    break;
    case 11:
  nllh[0] = amici::log((sigmay[11]*sigmay[11])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[11]*sigmay[11])*pow(my[11]-y[11],2.0)*5.0E-1;
    break;
    case 12:
  nllh[0] = amici::log((sigmay[12]*sigmay[12])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[12]*sigmay[12])*pow(my[12]-y[12],2.0)*5.0E-1;
    break;
    case 13:
  nllh[0] = amici::log((sigmay[13]*sigmay[13])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[13]*sigmay[13])*pow(my[13]-y[13],2.0)*5.0E-1;
    break;
    case 14:
  nllh[0] = amici::log((sigmay[14]*sigmay[14])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[14]*sigmay[14])*pow(my[14]-y[14],2.0)*5.0E-1;
    break;
}
}

