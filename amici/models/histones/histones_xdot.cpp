
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void xdot_histones(realtype *xdot, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w) {
  xdot[0] = w[0]+w[1]-p[1]*x[0]-p[2]*x[0];
  xdot[1] = -w[0]+w[2]+w[3]+p[1]*x[0]-p[4]*x[1]-p[5]*x[1];
  xdot[2] = -w[1]+w[4]+w[5]+p[2]*x[0]-x[2]*p[12]-x[2]*p[13];
  xdot[3] = -w[2]+w[6]+w[7]+p[4]*x[1]-p[7]*x[3]-p[8]*x[3];
  xdot[4] = -w[3]-w[4]+w[8]+w[9]+p[5]*x[1]+x[2]*p[12]-x[4]*p[16]-x[4]*p[17];
  xdot[5] = -w[5]+w[10]+w[11]+x[2]*p[13]-x[5]*p[26]-x[5]*p[27];
  xdot[6] = -w[6]+w[12]+p[7]*x[3]-p[10]*x[6];
  xdot[7] = -w[7]-w[8]+w[13]+w[14]+p[8]*x[3]+x[4]*p[16]-x[7]*p[20]-x[7]*p[21];
  xdot[8] = -w[9]-w[10]+w[15]+w[16]+x[4]*p[17]+x[5]*p[26]-x[8]*p[30]-x[8]*p[31];
  xdot[9] = -w[11]+w[17]+x[5]*p[27]-x[9]*p[39];
  xdot[10] = -w[12]-w[13]+w[18]+p[10]*x[6]+x[7]*p[20]-x[10]*p[24];
  xdot[11] = -w[14]-w[15]+w[19]+w[20]+x[7]*p[21]+x[8]*p[30]-x[11]*p[34]-x[11]*p[35];
  xdot[12] = -w[16]-w[17]+w[21]+x[8]*p[31]+x[9]*p[39]-x[12]*p[42];
  xdot[13] = -w[18]-w[19]+x[10]*p[24]+x[11]*p[34];
  xdot[14] = -w[20]-w[21]+x[11]*p[35]+x[12]*p[42];
}

