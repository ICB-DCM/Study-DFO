
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
#include <sundials/sundials_sparse.h> //SlsMat definition
typedef amici::realtype realtype;
#include <cmath> 

void JSparse_histones(SlsMat JSparse, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  JSparse->indexvals[0] = 0;
  JSparse->indexvals[1] = 1;
  JSparse->indexvals[2] = 2;
  JSparse->indexvals[3] = 0;
  JSparse->indexvals[4] = 1;
  JSparse->indexvals[5] = 3;
  JSparse->indexvals[6] = 4;
  JSparse->indexvals[7] = 0;
  JSparse->indexvals[8] = 2;
  JSparse->indexvals[9] = 4;
  JSparse->indexvals[10] = 5;
  JSparse->indexvals[11] = 1;
  JSparse->indexvals[12] = 3;
  JSparse->indexvals[13] = 6;
  JSparse->indexvals[14] = 7;
  JSparse->indexvals[15] = 1;
  JSparse->indexvals[16] = 2;
  JSparse->indexvals[17] = 4;
  JSparse->indexvals[18] = 7;
  JSparse->indexvals[19] = 8;
  JSparse->indexvals[20] = 2;
  JSparse->indexvals[21] = 5;
  JSparse->indexvals[22] = 8;
  JSparse->indexvals[23] = 9;
  JSparse->indexvals[24] = 3;
  JSparse->indexvals[25] = 6;
  JSparse->indexvals[26] = 10;
  JSparse->indexvals[27] = 3;
  JSparse->indexvals[28] = 4;
  JSparse->indexvals[29] = 7;
  JSparse->indexvals[30] = 10;
  JSparse->indexvals[31] = 11;
  JSparse->indexvals[32] = 4;
  JSparse->indexvals[33] = 5;
  JSparse->indexvals[34] = 8;
  JSparse->indexvals[35] = 11;
  JSparse->indexvals[36] = 12;
  JSparse->indexvals[37] = 5;
  JSparse->indexvals[38] = 9;
  JSparse->indexvals[39] = 12;
  JSparse->indexvals[40] = 6;
  JSparse->indexvals[41] = 7;
  JSparse->indexvals[42] = 10;
  JSparse->indexvals[43] = 13;
  JSparse->indexvals[44] = 7;
  JSparse->indexvals[45] = 8;
  JSparse->indexvals[46] = 11;
  JSparse->indexvals[47] = 13;
  JSparse->indexvals[48] = 14;
  JSparse->indexvals[49] = 8;
  JSparse->indexvals[50] = 9;
  JSparse->indexvals[51] = 12;
  JSparse->indexvals[52] = 14;
  JSparse->indexvals[53] = 10;
  JSparse->indexvals[54] = 11;
  JSparse->indexvals[55] = 13;
  JSparse->indexvals[56] = 11;
  JSparse->indexvals[57] = 12;
  JSparse->indexvals[58] = 14;
  JSparse->indexptrs[0] = 0;
  JSparse->indexptrs[1] = 3;
  JSparse->indexptrs[2] = 7;
  JSparse->indexptrs[3] = 11;
  JSparse->indexptrs[4] = 15;
  JSparse->indexptrs[5] = 20;
  JSparse->indexptrs[6] = 24;
  JSparse->indexptrs[7] = 27;
  JSparse->indexptrs[8] = 32;
  JSparse->indexptrs[9] = 37;
  JSparse->indexptrs[10] = 40;
  JSparse->indexptrs[11] = 44;
  JSparse->indexptrs[12] = 49;
  JSparse->indexptrs[13] = 53;
  JSparse->indexptrs[14] = 56;
  JSparse->indexptrs[15] = 59;
  JSparse->data[0] = -p[1]-p[2];
  JSparse->data[1] = p[1];
  JSparse->data[2] = p[2];
  JSparse->data[3] = dwdx[0];
  JSparse->data[4] = -p[4]-p[5]-dwdx[0];
  JSparse->data[5] = p[4];
  JSparse->data[6] = p[5];
  JSparse->data[7] = dwdx[1];
  JSparse->data[8] = -p[12]-p[13]-dwdx[1];
  JSparse->data[9] = p[12];
  JSparse->data[10] = p[13];
  JSparse->data[11] = dwdx[2];
  JSparse->data[12] = -p[7]-p[8]-dwdx[2];
  JSparse->data[13] = p[7];
  JSparse->data[14] = p[8];
  JSparse->data[15] = dwdx[3];
  JSparse->data[16] = dwdx[4];
  JSparse->data[17] = -p[16]-p[17]-dwdx[3]-dwdx[4];
  JSparse->data[18] = p[16];
  JSparse->data[19] = p[17];
  JSparse->data[20] = dwdx[5];
  JSparse->data[21] = -p[26]-p[27]-dwdx[5];
  JSparse->data[22] = p[26];
  JSparse->data[23] = p[27];
  JSparse->data[24] = dwdx[6];
  JSparse->data[25] = -p[10]-dwdx[6];
  JSparse->data[26] = p[10];
  JSparse->data[27] = dwdx[7];
  JSparse->data[28] = dwdx[8];
  JSparse->data[29] = -p[20]-p[21]-dwdx[7]-dwdx[8];
  JSparse->data[30] = p[20];
  JSparse->data[31] = p[21];
  JSparse->data[32] = dwdx[9];
  JSparse->data[33] = dwdx[10];
  JSparse->data[34] = -p[30]-p[31]-dwdx[9]-dwdx[10];
  JSparse->data[35] = p[30];
  JSparse->data[36] = p[31];
  JSparse->data[37] = dwdx[11];
  JSparse->data[38] = -p[39]-dwdx[11];
  JSparse->data[39] = p[39];
  JSparse->data[40] = dwdx[12];
  JSparse->data[41] = dwdx[13];
  JSparse->data[42] = -p[24]-dwdx[12]-dwdx[13];
  JSparse->data[43] = p[24];
  JSparse->data[44] = dwdx[14];
  JSparse->data[45] = dwdx[15];
  JSparse->data[46] = -p[34]-p[35]-dwdx[14]-dwdx[15];
  JSparse->data[47] = p[34];
  JSparse->data[48] = p[35];
  JSparse->data[49] = dwdx[16];
  JSparse->data[50] = dwdx[17];
  JSparse->data[51] = -p[42]-dwdx[16]-dwdx[17];
  JSparse->data[52] = p[42];
  JSparse->data[53] = dwdx[18];
  JSparse->data[54] = dwdx[19];
  JSparse->data[55] = -dwdx[18]-dwdx[19];
  JSparse->data[56] = dwdx[20];
  JSparse->data[57] = dwdx[21];
  JSparse->data[58] = -dwdx[20]-dwdx[21];
}

