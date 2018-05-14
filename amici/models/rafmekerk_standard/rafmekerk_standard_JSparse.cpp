
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
#include <sundials/sundials_sparse.h> //SlsMat definition
typedef amici::realtype realtype;
#include <cmath> 

void JSparse_rafmekerk_standard(SlsMat JSparse, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  JSparse->indexvals[0] = 0;
  JSparse->indexvals[1] = 1;
  JSparse->indexvals[2] = 1;
  JSparse->indexvals[3] = 2;
  JSparse->indexvals[4] = 0;
  JSparse->indexvals[5] = 2;
  JSparse->indexptrs[0] = 0;
  JSparse->indexptrs[1] = 2;
  JSparse->indexptrs[2] = 4;
  JSparse->indexptrs[3] = 6;
  JSparse->data[0] = -p[0]-(p[1]*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0)))/(x[2]/p[6]+1.0);
  JSparse->data[1] = -(p[3]*(x[1]-1.0))/(k[0]/p[10]+1.0);
  JSparse->data[2] = -p[2]-(p[3]*x[0])/(k[0]/p[10]+1.0);
  JSparse->data[3] = -(p[5]*(x[2]-1.0))/(k[1]/p[11]+1.0);
  JSparse->data[4] = (p[1]*1.0/pow(x[2]/p[6]+1.0,2.0)*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0))/p[6];
  JSparse->data[5] = -p[4]-(p[5]*x[1])/(k[1]/p[11]+1.0);
}

