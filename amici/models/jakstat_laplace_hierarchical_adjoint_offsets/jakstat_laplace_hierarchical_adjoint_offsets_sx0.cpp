
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void sx0_jakstat_laplace_hierarchical_adjoint_offsets(realtype *sx0, const realtype t,const realtype *x0, const realtype *p, const realtype *k, const int ip) {
switch (ip) {
  case 4: {
  sx0[0] = 1.0;

  } break;

}
}

