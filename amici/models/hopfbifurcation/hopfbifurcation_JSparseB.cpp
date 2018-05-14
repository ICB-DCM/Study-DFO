
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
#include <sundials/sundials_sparse.h> //SlsMat definition
typedef amici::realtype realtype;
#include <cmath> 

void JSparseB_hopfbifurcation(SlsMat JSparseB, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *w, const realtype *dwdx) {
  JSparseB->indexvals[0] = 0;
  JSparseB->indexvals[1] = 1;
  JSparseB->indexvals[2] = 1;
  JSparseB->indexvals[3] = 2;
  JSparseB->indexvals[4] = 0;
  JSparseB->indexvals[5] = 2;
  JSparseB->indexptrs[0] = 0;
  JSparseB->indexptrs[1] = 2;
  JSparseB->indexptrs[2] = 4;
  JSparseB->indexptrs[3] = 6;
  JSparseB->data[0] = -p[0]+p[3]+p[1]*x[1];
  JSparseB->data[1] = p[1]*x[0];
  JSparseB->data[2] = p[2];
  JSparseB->data[3] = -dwdx[0];
  JSparseB->data[4] = -p[3];
  JSparseB->data[5] = dwdx[0];
}

