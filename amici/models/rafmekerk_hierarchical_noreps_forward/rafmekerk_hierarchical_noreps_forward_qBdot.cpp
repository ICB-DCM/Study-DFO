
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void qBdot_rafmekerk_hierarchical_noreps_forward(realtype *qBdot, const int ip, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *w, const realtype *dwdp) {
switch (ip) {
  case 0: {
  qBdot[0] = x[0]*xB[0];

  } break;

  case 1: {
  qBdot[0] = (xB[0]*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0))/(x[2]/p[6]+1.0);

  } break;

  case 2: {
  qBdot[0] = x[1]*xB[1];

  } break;

  case 3: {
  qBdot[0] = (x[0]*xB[1]*(x[1]-1.0))/(k[0]/p[10]+1.0);

  } break;

  case 4: {
  qBdot[0] = x[2]*xB[2];

  } break;

  case 5: {
  qBdot[0] = (x[1]*xB[2]*(x[2]-1.0))/(k[1]/p[11]+1.0);

  } break;

  case 6: {
  qBdot[0] = p[1]*1.0/(p[6]*p[6])*x[2]*xB[0]*1.0/pow(x[2]/p[6]+1.0,2.0)*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0);

  } break;

  case 7: {
  qBdot[0] = (p[1]*xB[0]*(x[0]-1.0))/(x[2]/p[6]+1.0);

  } break;

  case 8: {
  qBdot[0] = -(t*p[1]*1.0/(p[8]*p[8])*xB[0]*exp(-t/p[8])*exp(-t/p[9])*(x[0]-1.0))/(x[2]/p[6]+1.0);

  } break;

  case 9: {
  qBdot[0] = -(t*p[1]*1.0/(p[9]*p[9])*xB[0]*exp(-t/p[9])*(exp(-t/p[8])-1.0)*(x[0]-1.0))/(x[2]/p[6]+1.0);

  } break;

  case 10: {
  qBdot[0] = k[0]*p[3]*x[0]*1.0/(p[10]*p[10])*xB[1]*1.0/pow(k[0]/p[10]+1.0,2.0)*(x[1]-1.0);

  } break;

  case 11: {
  qBdot[0] = k[1]*p[5]*x[1]*1.0/(p[11]*p[11])*xB[2]*1.0/pow(k[1]/p[11]+1.0,2.0)*(x[2]-1.0);

  } break;

}
}

