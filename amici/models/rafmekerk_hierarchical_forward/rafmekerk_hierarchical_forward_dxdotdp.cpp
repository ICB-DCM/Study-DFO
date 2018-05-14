
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dxdotdp_rafmekerk_hierarchical_forward(realtype *dxdotdp, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const int ip, const realtype *w, const realtype *dwdp) {
switch (ip) {
  case 0: {
  dxdotdp[0] = -x[0];

  } break;

  case 1: {
  dxdotdp[0] = -((p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0))/(x[2]/p[6]+1.0);

  } break;

  case 2: {
  dxdotdp[1] = -x[1];

  } break;

  case 3: {
  dxdotdp[1] = -(x[0]*(x[1]-1.0))/(k[0]/p[10]+1.0);

  } break;

  case 4: {
  dxdotdp[2] = -x[2];

  } break;

  case 5: {
  dxdotdp[2] = -(x[1]*(x[2]-1.0))/(k[1]/p[11]+1.0);

  } break;

  case 6: {
  dxdotdp[0] = -p[1]*1.0/(p[6]*p[6])*x[2]*1.0/pow(x[2]/p[6]+1.0,2.0)*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0);

  } break;

  case 7: {
  dxdotdp[0] = -(p[1]*(x[0]-1.0))/(x[2]/p[6]+1.0);

  } break;

  case 8: {
  dxdotdp[0] = (t*p[1]*1.0/(p[8]*p[8])*exp(-t/p[8])*exp(-t/p[9])*(x[0]-1.0))/(x[2]/p[6]+1.0);

  } break;

  case 9: {
  dxdotdp[0] = (t*p[1]*1.0/(p[9]*p[9])*exp(-t/p[9])*(exp(-t/p[8])-1.0)*(x[0]-1.0))/(x[2]/p[6]+1.0);

  } break;

  case 10: {
  dxdotdp[1] = -k[0]*p[3]*x[0]*1.0/(p[10]*p[10])*1.0/pow(k[0]/p[10]+1.0,2.0)*(x[1]-1.0);

  } break;

  case 11: {
  dxdotdp[2] = -k[1]*p[5]*x[1]*1.0/(p[11]*p[11])*1.0/pow(k[1]/p[11]+1.0,2.0)*(x[2]-1.0);

  } break;

}
}

