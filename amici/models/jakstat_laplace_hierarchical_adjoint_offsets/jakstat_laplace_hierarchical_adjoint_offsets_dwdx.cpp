
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dwdx_jakstat_laplace_hierarchical_adjoint_offsets(realtype *dwdx, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w) {
  dwdx[0] = x[1]*2.0;
}

