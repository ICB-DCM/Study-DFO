
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void JDiag_histonesPre(realtype *JDiag, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  JDiag[0+0*15] = -p[0]-p[1]-p[2];
  JDiag[1+0*15] = -p[0]-p[4]-p[5]-dwdx[0];
  JDiag[2+0*15] = -p[0]-p[12]-p[13]-dwdx[1];
  JDiag[3+0*15] = -p[0]-p[7]-p[8]-dwdx[2];
  JDiag[4+0*15] = -p[0]-p[16]-p[17]-dwdx[3]-dwdx[4];
  JDiag[5+0*15] = -p[0]-p[26]-p[27]-dwdx[5];
  JDiag[6+0*15] = -p[0]-p[10]-dwdx[6];
  JDiag[7+0*15] = -p[0]-p[20]-p[21]-dwdx[7]-dwdx[8];
  JDiag[8+0*15] = -p[0]-p[30]-p[31]-dwdx[9]-dwdx[10];
  JDiag[9+0*15] = -p[0]-p[39]-dwdx[11];
  JDiag[10+0*15] = -p[0]-p[24]-dwdx[12]-dwdx[13];
  JDiag[11+0*15] = -p[0]-p[34]-p[35]-dwdx[14]-dwdx[15];
  JDiag[12+0*15] = -p[0]-p[42]-dwdx[16]-dwdx[17];
  JDiag[13+0*15] = -p[0]-dwdx[18]-dwdx[19];
  JDiag[14+0*15] = -p[0]-dwdx[20]-dwdx[21];
}

