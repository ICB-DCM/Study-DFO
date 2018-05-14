
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void dydp_rafmekerk_standard(double *dydp, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const int ip) {
switch (ip) {
  case 12: {
  dydp[0] = x[1];

  } break;

  case 13: {
  dydp[1] = x[2];

  } break;

  case 14: {
  dydp[2] = x[1];

  } break;

  case 15: {
  dydp[3] = x[2];

  } break;

  case 16: {
  dydp[4] = x[1];

  } break;

  case 17: {
  dydp[5] = x[2];

  } break;

  case 18: {
  dydp[6] = x[1];

  } break;

  case 19: {
  dydp[7] = x[2];

  } break;

}
}

