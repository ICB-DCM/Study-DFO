
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
#include <sundials/sundials_sparse.h> //SlsMat definition
typedef amici::realtype realtype;
#include <cmath> 

void JSparseB_rafmekerk_hierarchical_noreps_adjoint(SlsMat JSparseB, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *xB, const realtype *w, const realtype *dwdx) {
  JSparseB->indexvals[0] = 0;
  JSparseB->indexvals[1] = 2;
  JSparseB->indexvals[2] = 0;
  JSparseB->indexvals[3] = 1;
  JSparseB->indexvals[4] = 1;
  JSparseB->indexvals[5] = 2;
  JSparseB->indexptrs[0] = 0;
  JSparseB->indexptrs[1] = 2;
  JSparseB->indexptrs[2] = 4;
  JSparseB->indexptrs[3] = 6;
  JSparseB->data[0] = p[0]+(p[1]*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0)))/(x[2]/p[6]+1.0);
  JSparseB->data[1] = -(p[1]*1.0/pow(x[2]/p[6]+1.0,2.0)*(p[7]-exp(-t/p[9])*(exp(-t/p[8])-1.0))*(x[0]-1.0))/p[6];
  JSparseB->data[2] = (p[3]*(x[1]-1.0))/(k[0]/p[10]+1.0);
  JSparseB->data[3] = p[2]+(p[3]*x[0])/(k[0]/p[10]+1.0);
  JSparseB->data[4] = (p[5]*(x[2]-1.0))/(k[1]/p[11]+1.0);
  JSparseB->data[5] = p[4]+(p[5]*x[1])/(k[1]/p[11]+1.0);
}

