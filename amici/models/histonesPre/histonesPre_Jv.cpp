
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void Jv_histonesPre(realtype *Jv, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *v, const realtype *w, const realtype *dwdx) {
  Jv[0] = v[1]*dwdx[0]+v[2]*dwdx[1]-v[0]*(p[0]+p[1]+p[2]);
  Jv[1] = -v[1]*(p[0]+p[4]+p[5]+dwdx[0])+p[1]*v[0]+v[3]*dwdx[2]+v[4]*dwdx[3];
  Jv[2] = -v[2]*(p[0]+p[12]+p[13]+dwdx[1])+p[2]*v[0]+v[4]*dwdx[4]+v[5]*dwdx[5];
  Jv[3] = -v[3]*(p[0]+p[7]+p[8]+dwdx[2])+p[4]*v[1]+v[6]*dwdx[6]+v[7]*dwdx[7];
  Jv[4] = p[5]*v[1]+v[2]*p[12]+v[7]*dwdx[8]+v[8]*dwdx[9]-v[4]*(p[0]+p[16]+p[17]+dwdx[3]+dwdx[4]);
  Jv[5] = -v[5]*(p[0]+p[26]+p[27]+dwdx[5])+v[2]*p[13]+v[8]*dwdx[10]+v[9]*dwdx[11];
  Jv[6] = p[7]*v[3]+v[10]*dwdx[12]-v[6]*(p[0]+p[10]+dwdx[6]);
  Jv[7] = p[8]*v[3]+v[4]*p[16]+v[10]*dwdx[13]+v[11]*dwdx[14]-v[7]*(p[0]+p[20]+p[21]+dwdx[7]+dwdx[8]);
  Jv[8] = v[4]*p[17]+v[5]*p[26]+v[11]*dwdx[15]+v[12]*dwdx[16]-v[8]*(p[0]+p[30]+p[31]+dwdx[9]+dwdx[10]);
  Jv[9] = v[5]*p[27]+v[12]*dwdx[17]-v[9]*(p[0]+p[39]+dwdx[11]);
  Jv[10] = -v[10]*(p[0]+p[24]+dwdx[12]+dwdx[13])+p[10]*v[6]+v[7]*p[20]+v[13]*dwdx[18];
  Jv[11] = v[7]*p[21]+v[8]*p[30]+v[13]*dwdx[19]+v[14]*dwdx[20]-v[11]*(p[0]+p[34]+p[35]+dwdx[14]+dwdx[15]);
  Jv[12] = -v[12]*(p[0]+p[42]+dwdx[16]+dwdx[17])+v[8]*p[31]+v[9]*p[39]+v[14]*dwdx[21];
  Jv[13] = v[10]*p[24]+v[11]*p[34]-v[13]*(p[0]+dwdx[18]+dwdx[19]);
  Jv[14] = v[11]*p[35]+v[12]*p[42]-v[14]*(p[0]+dwdx[20]+dwdx[21]);
}

