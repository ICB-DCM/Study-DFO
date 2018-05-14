
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void sigma_y_rafmekerk_laplace_hierarchical_adjoint(double *sigmay, const realtype t, const realtype *p, const realtype *k) {
  sigmay[0] = 1.0;
  sigmay[1] = 1.0;
}

