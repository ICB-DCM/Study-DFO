
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void w_jakstat_laplace_hierarchical_adjoint_offsets(realtype *w, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  w[0] = amici::spline_pos(t,5,0.0,p[5],5.0,p[6],1.0E1,p[7],2.0E1,p[8],6.0E1,p[9],0.0,0.0);
  w[1] = x[1]*x[1];
}

