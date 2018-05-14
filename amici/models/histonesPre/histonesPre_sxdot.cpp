
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void sxdot_histonesPre(realtype *sxdot, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const int ip, const realtype *sx, const realtype *w, const realtype *dwdx, const realtype *J, const realtype *dxdotdp) {
  sxdot[0] = dxdotdp[0]+J[0]*sx[0]+J[3]*sx[1]+J[7]*sx[2];
  sxdot[1] = dxdotdp[1]+J[1]*sx[0]+J[4]*sx[1]+J[11]*sx[3]+J[15]*sx[4];
  sxdot[2] = dxdotdp[2]+J[2]*sx[0]+J[8]*sx[2]+J[16]*sx[4]+J[20]*sx[5];
  sxdot[3] = dxdotdp[3]+J[5]*sx[1]+J[12]*sx[3]+J[24]*sx[6]+J[27]*sx[7];
  sxdot[4] = dxdotdp[4]+J[6]*sx[1]+J[9]*sx[2]+J[17]*sx[4]+J[28]*sx[7]+J[32]*sx[8];
  sxdot[5] = dxdotdp[5]+J[10]*sx[2]+J[21]*sx[5]+J[33]*sx[8]+J[37]*sx[9];
  sxdot[6] = dxdotdp[6]+J[13]*sx[3]+J[25]*sx[6]+J[40]*sx[10];
  sxdot[7] = dxdotdp[7]+J[14]*sx[3]+J[18]*sx[4]+J[29]*sx[7]+J[41]*sx[10]+J[44]*sx[11];
  sxdot[8] = dxdotdp[8]+J[19]*sx[4]+J[22]*sx[5]+J[34]*sx[8]+J[45]*sx[11]+J[49]*sx[12];
  sxdot[9] = dxdotdp[9]+J[23]*sx[5]+J[38]*sx[9]+J[50]*sx[12];
  sxdot[10] = dxdotdp[10]+J[26]*sx[6]+J[30]*sx[7]+J[42]*sx[10]+J[53]*sx[13];
  sxdot[11] = dxdotdp[11]+J[31]*sx[7]+J[35]*sx[8]+J[46]*sx[11]+J[54]*sx[13]+J[56]*sx[14];
  sxdot[12] = dxdotdp[12]+J[36]*sx[8]+J[39]*sx[9]+J[51]*sx[12]+J[57]*sx[14];
  sxdot[13] = dxdotdp[13]+J[43]*sx[10]+J[47]*sx[11]+J[55]*sx[13];
  sxdot[14] = dxdotdp[14]+J[48]*sx[11]+J[52]*sx[12]+J[58]*sx[14];
}

