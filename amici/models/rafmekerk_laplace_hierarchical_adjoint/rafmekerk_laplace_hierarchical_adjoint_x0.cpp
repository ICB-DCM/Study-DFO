
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

void x0_rafmekerk_laplace_hierarchical_adjoint(realtype *x0, const realtype t, const realtype *p, const realtype *k) {
  x0[0] = (p[6]*p[7]+sqrt((p[6]*p[6])*(p[7]*p[7])+(p[4]*(p[6]*p[6])*(p[7]*p[7])*2.0)/p[5]+(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*(p[7]*p[7])+(p[2]*p[2])*1.0/(p[3]*p[3])*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*pow(p[7]+p[0]/p[1],2.0)+(p[2]*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/p[3]+(p[2]*p[4]*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/(p[3]*p[5])+(p[0]*p[2]*p[4]*p[6]*p[7]*4.0)/(p[1]*p[3]*p[5]))+(p[4]*p[6]*p[7])/p[5]-(p[2]*p[4]*p[6]*(p[7]+p[0]/p[1]))/(p[3]*p[5]))/(p[6]*p[7]*2.0+(p[0]*2.0)/p[1]+(p[0]*p[6]*2.0)/p[1]+(p[4]*p[6]*p[7]*2.0)/p[5]+(p[0]*p[4]*p[6]*2.0)/(p[1]*p[5]));
  x0[1] = (p[6]*p[7]+sqrt((p[6]*p[6])*(p[7]*p[7])+(p[4]*(p[6]*p[6])*(p[7]*p[7])*2.0)/p[5]+(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*(p[7]*p[7])+(p[2]*p[2])*1.0/(p[3]*p[3])*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*pow(p[7]+p[0]/p[1],2.0)+(p[2]*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/p[3]+(p[2]*p[4]*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/(p[3]*p[5])+(p[0]*p[2]*p[4]*p[6]*p[7]*4.0)/(p[1]*p[3]*p[5]))+(p[4]*p[6]*p[7])/p[5]-(p[2]*p[4]*p[6]*p[7])/(p[3]*p[5])-(p[0]*p[2]*p[4]*p[6])/(p[1]*p[3]*p[5]))/(p[6]*p[7]+sqrt((p[6]*p[6])*(p[7]*p[7])+(p[4]*(p[6]*p[6])*(p[7]*p[7])*2.0)/p[5]+(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*(p[7]*p[7])+(p[2]*p[2])*1.0/(p[3]*p[3])*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*pow(p[7]+p[0]/p[1],2.0)+(p[2]*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/p[3]+(p[2]*p[4]*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/(p[3]*p[5])+(p[0]*p[2]*p[4]*p[6]*p[7]*4.0)/(p[1]*p[3]*p[5]))+(p[4]*p[6]*p[7])/p[5]+(p[0]*p[2]*(p[6]*2.0+(p[4]*p[6])/p[5]+2.0))/(p[1]*p[3])+(p[2]*p[6]*p[7]*(p[4]/p[5]+2.0))/p[3]);
  x0[2] = (p[6]*p[7]+sqrt((p[6]*p[6])*(p[7]*p[7])+(p[4]*(p[6]*p[6])*(p[7]*p[7])*2.0)/p[5]+(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*(p[7]*p[7])+(p[2]*p[2])*1.0/(p[3]*p[3])*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*pow(p[7]+p[0]/p[1],2.0)+(p[2]*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/p[3]+(p[2]*p[4]*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/(p[3]*p[5])+(p[0]*p[2]*p[4]*p[6]*p[7]*4.0)/(p[1]*p[3]*p[5]))+(p[4]*p[6]*p[7])/p[5]-(p[2]*p[4]*p[6]*p[7])/(p[3]*p[5])-(p[0]*p[2]*p[4]*p[6])/(p[1]*p[3]*p[5]))/((p[4]/p[5]+1.0)*sqrt((p[6]*p[6])*(p[7]*p[7])+(p[4]*(p[6]*p[6])*(p[7]*p[7])*2.0)/p[5]+(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*(p[7]*p[7])+(p[2]*p[2])*1.0/(p[3]*p[3])*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*pow(p[7]+p[0]/p[1],2.0)+(p[2]*(p[4]*p[4])*1.0/(p[5]*p[5])*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/p[3]+(p[2]*p[4]*(p[6]*p[6])*p[7]*(p[7]+p[0]/p[1])*2.0)/(p[3]*p[5])+(p[0]*p[2]*p[4]*p[6]*p[7]*4.0)/(p[1]*p[3]*p[5]))+p[6]*p[7]*pow(p[4]/p[5]+1.0,2.0)+(p[0]*p[2]*p[4]*(p[6]+(p[4]*p[6])/p[5]+2.0))/(p[1]*p[3]*p[5])+(p[2]*p[4]*p[6]*p[7]*(p[4]/p[5]+1.0))/(p[3]*p[5]));
}

