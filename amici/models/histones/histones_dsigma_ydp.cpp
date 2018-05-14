
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dsigma_ydp_histones(double *dsigmaydp, const realtype t, const realtype *p, const realtype *k, const int ip) {
switch (ip) {
  case 45: {
  dsigmaydp[ip*15 + 0] = 1.0;
  dsigmaydp[ip*15 + 1] = 1.0;
  dsigmaydp[ip*15 + 2] = 1.0;
  dsigmaydp[ip*15 + 3] = 1.0;
  dsigmaydp[ip*15 + 4] = 1.0;
  dsigmaydp[ip*15 + 5] = 1.0;
  dsigmaydp[ip*15 + 6] = 1.0;
  dsigmaydp[ip*15 + 7] = 1.0;
  dsigmaydp[ip*15 + 8] = 1.0;
  dsigmaydp[ip*15 + 9] = 1.0;
  dsigmaydp[ip*15 + 10] = 1.0;
  dsigmaydp[ip*15 + 11] = 1.0;
  dsigmaydp[ip*15 + 12] = 1.0;
  dsigmaydp[ip*15 + 13] = 1.0;
  dsigmaydp[ip*15 + 14] = 1.0;

  } break;

}
}

