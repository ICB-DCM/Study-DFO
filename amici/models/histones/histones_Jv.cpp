
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void Jv_histones(realtype *Jv, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *v, const realtype *w, const realtype *dwdx) {
  Jv[0] = -v[0]*(p[1]+p[2])+v[1]*dwdx[0]+v[2]*dwdx[1];
  Jv[1] = p[1]*v[0]+v[3]*dwdx[2]+v[4]*dwdx[3]-v[1]*(p[4]+p[5]+dwdx[0]);
  Jv[2] = p[2]*v[0]+v[4]*dwdx[4]+v[5]*dwdx[5]-v[2]*(p[12]+p[13]+dwdx[1]);
  Jv[3] = p[4]*v[1]+v[6]*dwdx[6]+v[7]*dwdx[7]-v[3]*(p[7]+p[8]+dwdx[2]);
  Jv[4] = -v[4]*(p[16]+p[17]+dwdx[3]+dwdx[4])+p[5]*v[1]+v[2]*p[12]+v[7]*dwdx[8]+v[8]*dwdx[9];
  Jv[5] = v[2]*p[13]+v[8]*dwdx[10]+v[9]*dwdx[11]-v[5]*(p[26]+p[27]+dwdx[5]);
  Jv[6] = -v[6]*(p[10]+dwdx[6])+p[7]*v[3]+v[10]*dwdx[12];
  Jv[7] = -v[7]*(p[20]+p[21]+dwdx[7]+dwdx[8])+p[8]*v[3]+v[4]*p[16]+v[10]*dwdx[13]+v[11]*dwdx[14];
  Jv[8] = -v[8]*(p[30]+p[31]+dwdx[9]+dwdx[10])+v[4]*p[17]+v[5]*p[26]+v[11]*dwdx[15]+v[12]*dwdx[16];
  Jv[9] = -v[9]*(p[39]+dwdx[11])+v[5]*p[27]+v[12]*dwdx[17];
  Jv[10] = p[10]*v[6]+v[7]*p[20]+v[13]*dwdx[18]-v[10]*(p[24]+dwdx[12]+dwdx[13]);
  Jv[11] = -v[11]*(p[34]+p[35]+dwdx[14]+dwdx[15])+v[7]*p[21]+v[8]*p[30]+v[13]*dwdx[19]+v[14]*dwdx[20];
  Jv[12] = v[8]*p[31]+v[9]*p[39]+v[14]*dwdx[21]-v[12]*(p[42]+dwdx[16]+dwdx[17]);
  Jv[13] = -v[13]*(dwdx[18]+dwdx[19])+v[10]*p[24]+v[11]*p[34];
  Jv[14] = -v[14]*(dwdx[20]+dwdx[21])+v[11]*p[35]+v[12]*p[42];
}

