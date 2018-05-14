
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void qBdot_histonesPre(realtype *qBdot, const int ip, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *w, const realtype *dwdp) {
switch (ip) {
  case 0: {
  qBdot[0] = x[1]*xB[1]+x[2]*xB[2]+x[3]*xB[3]+x[4]*xB[4]+x[5]*xB[5]+x[6]*xB[6]+x[7]*xB[7]+x[8]*xB[8]+x[9]*xB[9]+x[10]*xB[10]+x[11]*xB[11]+x[12]*xB[12]+x[13]*xB[13]+x[14]*xB[14]+xB[0]*(x[0]-1.0);

  } break;

  case 1: {
  qBdot[0] = x[0]*xB[0]-x[0]*xB[1];

  } break;

  case 2: {
  qBdot[0] = x[0]*xB[0]-x[0]*xB[2];

  } break;

  case 3: {
  qBdot[0] = -xB[0]*dwdp[0]+xB[1]*dwdp[0];

  } break;

  case 4: {
  qBdot[0] = x[1]*xB[1]-x[1]*xB[3];

  } break;

  case 5: {
  qBdot[0] = x[1]*xB[1]-x[1]*xB[4];

  } break;

  case 6: {
  qBdot[0] = -xB[1]*dwdp[1]+xB[3]*dwdp[1];

  } break;

  case 7: {
  qBdot[0] = x[3]*xB[3]-x[3]*xB[6];

  } break;

  case 8: {
  qBdot[0] = x[3]*xB[3]-x[3]*xB[7];

  } break;

  case 9: {
  qBdot[0] = -xB[3]*dwdp[2]+xB[6]*dwdp[2];

  } break;

  case 10: {
  qBdot[0] = x[6]*xB[6]-x[6]*xB[10];

  } break;

  case 11: {
  qBdot[0] = -xB[0]*dwdp[3]+xB[2]*dwdp[3];

  } break;

  case 12: {
  qBdot[0] = x[2]*xB[2]-x[2]*xB[4];

  } break;

  case 13: {
  qBdot[0] = x[2]*xB[2]-x[2]*xB[5];

  } break;

  case 14: {
  qBdot[0] = -xB[1]*dwdp[4]+xB[4]*dwdp[4];

  } break;

  case 15: {
  qBdot[0] = -xB[2]*dwdp[5]+xB[4]*dwdp[5];

  } break;

  case 16: {
  qBdot[0] = x[4]*xB[4]-x[4]*xB[7];

  } break;

  case 17: {
  qBdot[0] = x[4]*xB[4]-x[4]*xB[8];

  } break;

  case 18: {
  qBdot[0] = -xB[3]*dwdp[6]+xB[7]*dwdp[6];

  } break;

  case 19: {
  qBdot[0] = -xB[4]*dwdp[7]+xB[7]*dwdp[7];

  } break;

  case 20: {
  qBdot[0] = x[7]*xB[7]-x[7]*xB[10];

  } break;

  case 21: {
  qBdot[0] = x[7]*xB[7]-x[7]*xB[11];

  } break;

  case 22: {
  qBdot[0] = -xB[6]*dwdp[8]+xB[10]*dwdp[8];

  } break;

  case 23: {
  qBdot[0] = -xB[7]*dwdp[9]+xB[10]*dwdp[9];

  } break;

  case 24: {
  qBdot[0] = x[10]*xB[10]-x[10]*xB[13];

  } break;

  case 25: {
  qBdot[0] = -xB[2]*dwdp[10]+xB[5]*dwdp[10];

  } break;

  case 26: {
  qBdot[0] = x[5]*xB[5]-x[5]*xB[8];

  } break;

  case 27: {
  qBdot[0] = x[5]*xB[5]-x[5]*xB[9];

  } break;

  case 28: {
  qBdot[0] = -xB[4]*dwdp[11]+xB[8]*dwdp[11];

  } break;

  case 29: {
  qBdot[0] = -xB[5]*dwdp[12]+xB[8]*dwdp[12];

  } break;

  case 30: {
  qBdot[0] = x[8]*xB[8]-x[8]*xB[11];

  } break;

  case 31: {
  qBdot[0] = x[8]*xB[8]-x[8]*xB[12];

  } break;

  case 32: {
  qBdot[0] = -xB[7]*dwdp[13]+xB[11]*dwdp[13];

  } break;

  case 33: {
  qBdot[0] = -xB[8]*dwdp[14]+xB[11]*dwdp[14];

  } break;

  case 34: {
  qBdot[0] = x[11]*xB[11]-x[11]*xB[13];

  } break;

  case 35: {
  qBdot[0] = x[11]*xB[11]-x[11]*xB[14];

  } break;

  case 36: {
  qBdot[0] = -xB[10]*dwdp[15]+xB[13]*dwdp[15];

  } break;

  case 37: {
  qBdot[0] = -xB[11]*dwdp[16]+xB[13]*dwdp[16];

  } break;

  case 38: {
  qBdot[0] = -xB[5]*dwdp[17]+xB[9]*dwdp[17];

  } break;

  case 39: {
  qBdot[0] = x[9]*xB[9]-x[9]*xB[12];

  } break;

  case 40: {
  qBdot[0] = -xB[8]*dwdp[18]+xB[12]*dwdp[18];

  } break;

  case 41: {
  qBdot[0] = -xB[9]*dwdp[19]+xB[12]*dwdp[19];

  } break;

  case 42: {
  qBdot[0] = x[12]*xB[12]-x[12]*xB[14];

  } break;

  case 43: {
  qBdot[0] = -xB[11]*dwdp[20]+xB[14]*dwdp[20];

  } break;

  case 44: {
  qBdot[0] = -xB[12]*dwdp[21]+xB[14]*dwdp[21];

  } break;

}
}

