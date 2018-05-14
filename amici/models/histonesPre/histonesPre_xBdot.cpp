
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void xBdot_histonesPre(realtype *xBdot, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *w, const realtype *dwdx) {
  xBdot[0] = -p[1]*xB[1]-p[2]*xB[2]+xB[0]*(p[0]+p[1]+p[2]);
  xBdot[1] = xB[1]*(p[0]+p[4]+p[5]+dwdx[0])-p[4]*xB[3]-p[5]*xB[4]-xB[0]*dwdx[0];
  xBdot[2] = xB[2]*(p[0]+p[12]+p[13]+dwdx[1])-p[12]*xB[4]-p[13]*xB[5]-xB[0]*dwdx[1];
  xBdot[3] = xB[3]*(p[0]+p[7]+p[8]+dwdx[2])-p[7]*xB[6]-p[8]*xB[7]-xB[1]*dwdx[2];
  xBdot[4] = -p[16]*xB[7]-p[17]*xB[8]-xB[1]*dwdx[3]-xB[2]*dwdx[4]+xB[4]*(p[0]+p[16]+p[17]+dwdx[3]+dwdx[4]);
  xBdot[5] = xB[5]*(p[0]+p[26]+p[27]+dwdx[5])-p[26]*xB[8]-p[27]*xB[9]-xB[2]*dwdx[5];
  xBdot[6] = -p[10]*xB[10]-xB[3]*dwdx[6]+xB[6]*(p[0]+p[10]+dwdx[6]);
  xBdot[7] = -p[20]*xB[10]-p[21]*xB[11]-xB[3]*dwdx[7]-xB[4]*dwdx[8]+xB[7]*(p[0]+p[20]+p[21]+dwdx[7]+dwdx[8]);
  xBdot[8] = -p[30]*xB[11]-p[31]*xB[12]-xB[4]*dwdx[9]-xB[5]*dwdx[10]+xB[8]*(p[0]+p[30]+p[31]+dwdx[9]+dwdx[10]);
  xBdot[9] = -p[39]*xB[12]-xB[5]*dwdx[11]+xB[9]*(p[0]+p[39]+dwdx[11]);
  xBdot[10] = xB[10]*(p[0]+p[24]+dwdx[12]+dwdx[13])-p[24]*xB[13]-xB[6]*dwdx[12]-xB[7]*dwdx[13];
  xBdot[11] = -p[34]*xB[13]-p[35]*xB[14]-xB[7]*dwdx[14]-xB[8]*dwdx[15]+xB[11]*(p[0]+p[34]+p[35]+dwdx[14]+dwdx[15]);
  xBdot[12] = xB[12]*(p[0]+p[42]+dwdx[16]+dwdx[17])-p[42]*xB[14]-xB[8]*dwdx[16]-xB[9]*dwdx[17];
  xBdot[13] = -xB[10]*dwdx[18]-xB[11]*dwdx[19]+xB[13]*(p[0]+dwdx[18]+dwdx[19]);
  xBdot[14] = -xB[11]*dwdx[20]-xB[12]*dwdx[21]+xB[14]*(p[0]+dwdx[20]+dwdx[21]);
}

