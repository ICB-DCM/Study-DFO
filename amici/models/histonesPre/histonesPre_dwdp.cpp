
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dwdp_histonesPre(realtype *dwdp, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w) {
  dwdp[0] = x[1];
  dwdp[1] = x[3];
  dwdp[2] = x[6];
  dwdp[3] = x[2];
  dwdp[4] = x[4];
  dwdp[5] = x[4];
  dwdp[6] = x[7];
  dwdp[7] = x[7];
  dwdp[8] = x[10];
  dwdp[9] = x[10];
  dwdp[10] = x[5];
  dwdp[11] = x[8];
  dwdp[12] = x[8];
  dwdp[13] = x[11];
  dwdp[14] = x[11];
  dwdp[15] = x[13];
  dwdp[16] = x[13];
  dwdp[17] = x[9];
  dwdp[18] = x[12];
  dwdp[19] = x[12];
  dwdp[20] = x[14];
  dwdp[21] = x[14];
}

