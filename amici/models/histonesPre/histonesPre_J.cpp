
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void J_histonesPre(realtype *J, const realtype t, const realtype *x, const double *p, const double *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  J[0+0*15] = -p[0]-p[1]-p[2];
  J[0+1*15] = dwdx[0];
  J[0+2*15] = dwdx[1];
  J[1+0*15] = p[1];
  J[1+1*15] = -p[0]-p[4]-p[5]-dwdx[0];
  J[1+3*15] = dwdx[2];
  J[1+4*15] = dwdx[3];
  J[2+0*15] = p[2];
  J[2+2*15] = -p[0]-p[12]-p[13]-dwdx[1];
  J[2+4*15] = dwdx[4];
  J[2+5*15] = dwdx[5];
  J[3+1*15] = p[4];
  J[3+3*15] = -p[0]-p[7]-p[8]-dwdx[2];
  J[3+6*15] = dwdx[6];
  J[3+7*15] = dwdx[7];
  J[4+1*15] = p[5];
  J[4+2*15] = p[12];
  J[4+4*15] = -p[0]-p[16]-p[17]-dwdx[3]-dwdx[4];
  J[4+7*15] = dwdx[8];
  J[4+8*15] = dwdx[9];
  J[5+2*15] = p[13];
  J[5+5*15] = -p[0]-p[26]-p[27]-dwdx[5];
  J[5+8*15] = dwdx[10];
  J[5+9*15] = dwdx[11];
  J[6+3*15] = p[7];
  J[6+6*15] = -p[0]-p[10]-dwdx[6];
  J[6+10*15] = dwdx[12];
  J[7+3*15] = p[8];
  J[7+4*15] = p[16];
  J[7+7*15] = -p[0]-p[20]-p[21]-dwdx[7]-dwdx[8];
  J[7+10*15] = dwdx[13];
  J[7+11*15] = dwdx[14];
  J[8+4*15] = p[17];
  J[8+5*15] = p[26];
  J[8+8*15] = -p[0]-p[30]-p[31]-dwdx[9]-dwdx[10];
  J[8+11*15] = dwdx[15];
  J[8+12*15] = dwdx[16];
  J[9+5*15] = p[27];
  J[9+9*15] = -p[0]-p[39]-dwdx[11];
  J[9+12*15] = dwdx[17];
  J[10+6*15] = p[10];
  J[10+7*15] = p[20];
  J[10+10*15] = -p[0]-p[24]-dwdx[12]-dwdx[13];
  J[10+13*15] = dwdx[18];
  J[11+7*15] = p[21];
  J[11+8*15] = p[30];
  J[11+11*15] = -p[0]-p[34]-p[35]-dwdx[14]-dwdx[15];
  J[11+13*15] = dwdx[19];
  J[11+14*15] = dwdx[20];
  J[12+8*15] = p[31];
  J[12+9*15] = p[39];
  J[12+12*15] = -p[0]-p[42]-dwdx[16]-dwdx[17];
  J[12+14*15] = dwdx[21];
  J[13+10*15] = p[24];
  J[13+11*15] = p[34];
  J[13+13*15] = -p[0]-dwdx[18]-dwdx[19];
  J[14+11*15] = p[35];
  J[14+12*15] = p[42];
  J[14+14*15] = -p[0]-dwdx[20]-dwdx[21];
}

