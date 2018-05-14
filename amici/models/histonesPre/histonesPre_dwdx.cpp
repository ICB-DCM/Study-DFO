
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dwdx_histonesPre(realtype *dwdx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w) {
  dwdx[0] = p[3];
  dwdx[1] = p[11];
  dwdx[2] = p[6];
  dwdx[3] = p[14];
  dwdx[4] = p[15];
  dwdx[5] = p[25];
  dwdx[6] = p[9];
  dwdx[7] = p[18];
  dwdx[8] = p[19];
  dwdx[9] = p[28];
  dwdx[10] = p[29];
  dwdx[11] = p[38];
  dwdx[12] = p[22];
  dwdx[13] = p[23];
  dwdx[14] = p[32];
  dwdx[15] = p[33];
  dwdx[16] = p[40];
  dwdx[17] = p[41];
  dwdx[18] = p[36];
  dwdx[19] = p[37];
  dwdx[20] = p[43];
  dwdx[21] = p[44];
}

