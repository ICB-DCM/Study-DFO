
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dxdotdp_histonesPre(realtype *dxdotdp, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const int ip, const realtype *w, const realtype *dwdp) {
switch (ip) {
  case 0: {
  dxdotdp[0] = -x[0]+1.0;
  dxdotdp[1] = -x[1];
  dxdotdp[2] = -x[2];
  dxdotdp[3] = -x[3];
  dxdotdp[4] = -x[4];
  dxdotdp[5] = -x[5];
  dxdotdp[6] = -x[6];
  dxdotdp[7] = -x[7];
  dxdotdp[8] = -x[8];
  dxdotdp[9] = -x[9];
  dxdotdp[10] = -x[10];
  dxdotdp[11] = -x[11];
  dxdotdp[12] = -x[12];
  dxdotdp[13] = -x[13];
  dxdotdp[14] = -x[14];

  } break;

  case 1: {
  dxdotdp[0] = -x[0];
  dxdotdp[1] = x[0];

  } break;

  case 2: {
  dxdotdp[0] = -x[0];
  dxdotdp[2] = x[0];

  } break;

  case 3: {
  dxdotdp[0] = dwdp[0];
  dxdotdp[1] = -dwdp[0];

  } break;

  case 4: {
  dxdotdp[1] = -x[1];
  dxdotdp[3] = x[1];

  } break;

  case 5: {
  dxdotdp[1] = -x[1];
  dxdotdp[4] = x[1];

  } break;

  case 6: {
  dxdotdp[1] = dwdp[1];
  dxdotdp[3] = -dwdp[1];

  } break;

  case 7: {
  dxdotdp[3] = -x[3];
  dxdotdp[6] = x[3];

  } break;

  case 8: {
  dxdotdp[3] = -x[3];
  dxdotdp[7] = x[3];

  } break;

  case 9: {
  dxdotdp[3] = dwdp[2];
  dxdotdp[6] = -dwdp[2];

  } break;

  case 10: {
  dxdotdp[6] = -x[6];
  dxdotdp[10] = x[6];

  } break;

  case 11: {
  dxdotdp[0] = dwdp[3];
  dxdotdp[2] = -dwdp[3];

  } break;

  case 12: {
  dxdotdp[2] = -x[2];
  dxdotdp[4] = x[2];

  } break;

  case 13: {
  dxdotdp[2] = -x[2];
  dxdotdp[5] = x[2];

  } break;

  case 14: {
  dxdotdp[1] = dwdp[4];
  dxdotdp[4] = -dwdp[4];

  } break;

  case 15: {
  dxdotdp[2] = dwdp[5];
  dxdotdp[4] = -dwdp[5];

  } break;

  case 16: {
  dxdotdp[4] = -x[4];
  dxdotdp[7] = x[4];

  } break;

  case 17: {
  dxdotdp[4] = -x[4];
  dxdotdp[8] = x[4];

  } break;

  case 18: {
  dxdotdp[3] = dwdp[6];
  dxdotdp[7] = -dwdp[6];

  } break;

  case 19: {
  dxdotdp[4] = dwdp[7];
  dxdotdp[7] = -dwdp[7];

  } break;

  case 20: {
  dxdotdp[7] = -x[7];
  dxdotdp[10] = x[7];

  } break;

  case 21: {
  dxdotdp[7] = -x[7];
  dxdotdp[11] = x[7];

  } break;

  case 22: {
  dxdotdp[6] = dwdp[8];
  dxdotdp[10] = -dwdp[8];

  } break;

  case 23: {
  dxdotdp[7] = dwdp[9];
  dxdotdp[10] = -dwdp[9];

  } break;

  case 24: {
  dxdotdp[10] = -x[10];
  dxdotdp[13] = x[10];

  } break;

  case 25: {
  dxdotdp[2] = dwdp[10];
  dxdotdp[5] = -dwdp[10];

  } break;

  case 26: {
  dxdotdp[5] = -x[5];
  dxdotdp[8] = x[5];

  } break;

  case 27: {
  dxdotdp[5] = -x[5];
  dxdotdp[9] = x[5];

  } break;

  case 28: {
  dxdotdp[4] = dwdp[11];
  dxdotdp[8] = -dwdp[11];

  } break;

  case 29: {
  dxdotdp[5] = dwdp[12];
  dxdotdp[8] = -dwdp[12];

  } break;

  case 30: {
  dxdotdp[8] = -x[8];
  dxdotdp[11] = x[8];

  } break;

  case 31: {
  dxdotdp[8] = -x[8];
  dxdotdp[12] = x[8];

  } break;

  case 32: {
  dxdotdp[7] = dwdp[13];
  dxdotdp[11] = -dwdp[13];

  } break;

  case 33: {
  dxdotdp[8] = dwdp[14];
  dxdotdp[11] = -dwdp[14];

  } break;

  case 34: {
  dxdotdp[11] = -x[11];
  dxdotdp[13] = x[11];

  } break;

  case 35: {
  dxdotdp[11] = -x[11];
  dxdotdp[14] = x[11];

  } break;

  case 36: {
  dxdotdp[10] = dwdp[15];
  dxdotdp[13] = -dwdp[15];

  } break;

  case 37: {
  dxdotdp[11] = dwdp[16];
  dxdotdp[13] = -dwdp[16];

  } break;

  case 38: {
  dxdotdp[5] = dwdp[17];
  dxdotdp[9] = -dwdp[17];

  } break;

  case 39: {
  dxdotdp[9] = -x[9];
  dxdotdp[12] = x[9];

  } break;

  case 40: {
  dxdotdp[8] = dwdp[18];
  dxdotdp[12] = -dwdp[18];

  } break;

  case 41: {
  dxdotdp[9] = dwdp[19];
  dxdotdp[12] = -dwdp[19];

  } break;

  case 42: {
  dxdotdp[12] = -x[12];
  dxdotdp[14] = x[12];

  } break;

  case 43: {
  dxdotdp[11] = dwdp[20];
  dxdotdp[14] = -dwdp[20];

  } break;

  case 44: {
  dxdotdp[12] = dwdp[21];
  dxdotdp[14] = -dwdp[21];

  } break;

}
}

