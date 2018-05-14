
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dsigma_ydp_rafmekerk_laplace_standard(double *dsigmaydp, const realtype t, const realtype *p, const realtype *k, const int ip) {
switch (ip) {
  case 20: {
  dsigmaydp[ip*8 + 0] = 1.0;

  } break;

  case 21: {
  dsigmaydp[ip*8 + 1] = 1.0;

  } break;

  case 22: {
  dsigmaydp[ip*8 + 2] = 1.0;

  } break;

  case 23: {
  dsigmaydp[ip*8 + 3] = 1.0;

  } break;

  case 24: {
  dsigmaydp[ip*8 + 4] = 1.0;

  } break;

  case 25: {
  dsigmaydp[ip*8 + 5] = 1.0;

  } break;

  case 26: {
  dsigmaydp[ip*8 + 6] = 1.0;

  } break;

  case 27: {
  dsigmaydp[ip*8 + 7] = 1.0;

  } break;

}
}

