
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void sx0_hopfbifurcation(realtype *sx0, const realtype t,const realtype *x0, const realtype *p, const realtype *k, const int ip) {
switch (ip) {
  case 5: {
  sx0[0] = 1.0;

  } break;

  case 6: {
  sx0[1] = 1.0;

  } break;

  case 7: {
  sx0[2] = 1.0;

  } break;

}
}

