
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void w_histonesPre(realtype *w, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  w[0] = p[3]*x[1];
  w[1] = x[2]*p[11];
  w[2] = p[6]*x[3];
  w[3] = x[4]*p[14];
  w[4] = x[4]*p[15];
  w[5] = x[5]*p[25];
  w[6] = p[9]*x[6];
  w[7] = x[7]*p[18];
  w[8] = x[7]*p[19];
  w[9] = x[8]*p[28];
  w[10] = x[8]*p[29];
  w[11] = x[9]*p[38];
  w[12] = x[10]*p[22];
  w[13] = x[10]*p[23];
  w[14] = x[11]*p[32];
  w[15] = x[11]*p[33];
  w[16] = x[12]*p[40];
  w[17] = x[12]*p[41];
  w[18] = x[13]*p[36];
  w[19] = x[13]*p[37];
  w[20] = x[14]*p[43];
  w[21] = x[14]*p[44];
}

