
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
#include <sundials/sundials_sparse.h> //SlsMat definition
typedef amici::realtype realtype;
#include <cmath> 

void JSparse_hopfbifurcation(SlsMat JSparse, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  JSparse->indexvals[0] = 0;
  JSparse->indexvals[1] = 2;
  JSparse->indexvals[2] = 0;
  JSparse->indexvals[3] = 1;
  JSparse->indexvals[4] = 1;
  JSparse->indexvals[5] = 2;
  JSparse->indexptrs[0] = 0;
  JSparse->indexptrs[1] = 2;
  JSparse->indexptrs[2] = 4;
  JSparse->indexptrs[3] = 6;
  JSparse->data[0] = p[0]-p[3]-p[1]*x[1];
  JSparse->data[1] = p[3];
  JSparse->data[2] = -p[1]*x[0];
  JSparse->data[3] = -p[2];
  JSparse->data[4] = dwdx[0];
  JSparse->data[5] = -dwdx[0];
}

