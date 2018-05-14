
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void root_erbb_hierarchical_forward(realtype *root, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h) {
  root[0] = -t+2.65999E3;
  root[1] = -t+1.79999E3;
  root[2] = t-1.8E3;
  root[3] = t-2.66E3;
}

