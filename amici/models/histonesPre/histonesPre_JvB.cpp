
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void JvB_histonesPre(realtype *JvB, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *vB, const realtype *w, const realtype *dwdx) {
  JvB[0] = -p[1]*vB[1]-p[2]*vB[2]+vB[0]*(p[0]+p[1]+p[2]);
  JvB[1] = vB[1]*(p[0]+p[4]+p[5]+dwdx[0])-p[4]*vB[3]-p[5]*vB[4]-vB[0]*dwdx[0];
  JvB[2] = vB[2]*(p[0]+p[12]+p[13]+dwdx[1])-p[12]*vB[4]-p[13]*vB[5]-vB[0]*dwdx[1];
  JvB[3] = vB[3]*(p[0]+p[7]+p[8]+dwdx[2])-p[7]*vB[6]-p[8]*vB[7]-vB[1]*dwdx[2];
  JvB[4] = -p[16]*vB[7]-p[17]*vB[8]-vB[1]*dwdx[3]-vB[2]*dwdx[4]+vB[4]*(p[0]+p[16]+p[17]+dwdx[3]+dwdx[4]);
  JvB[5] = vB[5]*(p[0]+p[26]+p[27]+dwdx[5])-p[26]*vB[8]-p[27]*vB[9]-vB[2]*dwdx[5];
  JvB[6] = -p[10]*vB[10]-vB[3]*dwdx[6]+vB[6]*(p[0]+p[10]+dwdx[6]);
  JvB[7] = -p[20]*vB[10]-p[21]*vB[11]-vB[3]*dwdx[7]-vB[4]*dwdx[8]+vB[7]*(p[0]+p[20]+p[21]+dwdx[7]+dwdx[8]);
  JvB[8] = -p[30]*vB[11]-p[31]*vB[12]-vB[4]*dwdx[9]-vB[5]*dwdx[10]+vB[8]*(p[0]+p[30]+p[31]+dwdx[9]+dwdx[10]);
  JvB[9] = -p[39]*vB[12]-vB[5]*dwdx[11]+vB[9]*(p[0]+p[39]+dwdx[11]);
  JvB[10] = vB[10]*(p[0]+p[24]+dwdx[12]+dwdx[13])-p[24]*vB[13]-vB[6]*dwdx[12]-vB[7]*dwdx[13];
  JvB[11] = -p[34]*vB[13]-p[35]*vB[14]-vB[7]*dwdx[14]-vB[8]*dwdx[15]+vB[11]*(p[0]+p[34]+p[35]+dwdx[14]+dwdx[15]);
  JvB[12] = vB[12]*(p[0]+p[42]+dwdx[16]+dwdx[17])-p[42]*vB[14]-vB[8]*dwdx[16]-vB[9]*dwdx[17];
  JvB[13] = -vB[10]*dwdx[18]-vB[11]*dwdx[19]+vB[13]*(p[0]+dwdx[18]+dwdx[19]);
  JvB[14] = -vB[11]*dwdx[20]-vB[12]*dwdx[21]+vB[14]*(p[0]+dwdx[20]+dwdx[21]);
}

