
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void sxdot_rafmekerk_hierarchical_forward(realtype *sxdot, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const int ip, const realtype *sx, const realtype *w, const realtype *dwdx, const realtype *J, const realtype *dxdotdp) {
  sxdot[0] = dxdotdp[0]+J[0]*sx[0]+J[4]*sx[2];
  sxdot[1] = dxdotdp[1]+J[1]*sx[0]+J[2]*sx[1];
  sxdot[2] = dxdotdp[2]+J[3]*sx[1]+J[5]*sx[2];
}

