
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void JB_histonesPre(realtype *JB, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *w, const realtype *dwdx) {
  JB[0+0*15] = p[0]+p[1]+p[2];
  JB[0+1*15] = -p[1];
  JB[0+2*15] = -p[2];
  JB[1+0*15] = -dwdx[0];
  JB[1+1*15] = p[0]+p[4]+p[5]+dwdx[0];
  JB[1+3*15] = -p[4];
  JB[1+4*15] = -p[5];
  JB[2+0*15] = -dwdx[1];
  JB[2+2*15] = p[0]+p[12]+p[13]+dwdx[1];
  JB[2+4*15] = -p[12];
  JB[2+5*15] = -p[13];
  JB[3+1*15] = -dwdx[2];
  JB[3+3*15] = p[0]+p[7]+p[8]+dwdx[2];
  JB[3+6*15] = -p[7];
  JB[3+7*15] = -p[8];
  JB[4+1*15] = -dwdx[3];
  JB[4+2*15] = -dwdx[4];
  JB[4+4*15] = p[0]+p[16]+p[17]+dwdx[3]+dwdx[4];
  JB[4+7*15] = -p[16];
  JB[4+8*15] = -p[17];
  JB[5+2*15] = -dwdx[5];
  JB[5+5*15] = p[0]+p[26]+p[27]+dwdx[5];
  JB[5+8*15] = -p[26];
  JB[5+9*15] = -p[27];
  JB[6+3*15] = -dwdx[6];
  JB[6+6*15] = p[0]+p[10]+dwdx[6];
  JB[6+10*15] = -p[10];
  JB[7+3*15] = -dwdx[7];
  JB[7+4*15] = -dwdx[8];
  JB[7+7*15] = p[0]+p[20]+p[21]+dwdx[7]+dwdx[8];
  JB[7+10*15] = -p[20];
  JB[7+11*15] = -p[21];
  JB[8+4*15] = -dwdx[9];
  JB[8+5*15] = -dwdx[10];
  JB[8+8*15] = p[0]+p[30]+p[31]+dwdx[9]+dwdx[10];
  JB[8+11*15] = -p[30];
  JB[8+12*15] = -p[31];
  JB[9+5*15] = -dwdx[11];
  JB[9+9*15] = p[0]+p[39]+dwdx[11];
  JB[9+12*15] = -p[39];
  JB[10+6*15] = -dwdx[12];
  JB[10+7*15] = -dwdx[13];
  JB[10+10*15] = p[0]+p[24]+dwdx[12]+dwdx[13];
  JB[10+13*15] = -p[24];
  JB[11+7*15] = -dwdx[14];
  JB[11+8*15] = -dwdx[15];
  JB[11+11*15] = p[0]+p[34]+p[35]+dwdx[14]+dwdx[15];
  JB[11+13*15] = -p[34];
  JB[11+14*15] = -p[35];
  JB[12+8*15] = -dwdx[16];
  JB[12+9*15] = -dwdx[17];
  JB[12+12*15] = p[0]+p[42]+dwdx[16]+dwdx[17];
  JB[12+14*15] = -p[42];
  JB[13+10*15] = -dwdx[18];
  JB[13+11*15] = -dwdx[19];
  JB[13+13*15] = p[0]+dwdx[18]+dwdx[19];
  JB[14+11*15] = -dwdx[20];
  JB[14+12*15] = -dwdx[21];
  JB[14+14*15] = p[0]+dwdx[20]+dwdx[21];
}

