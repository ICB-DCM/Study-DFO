void examplePC(unsigned np1, unsigned np2, unsigned nx, double p1[], char p2[], double x[],
               double *nc, double *f, double c[], double df[], double dc[])
{
double f1 = x[0]*x[0] + x[1]*x[1];
double f2 = x[0]*x[0]*x[1] + x[1]*(1-x[1]);

*nc = 0;

/* if (p2[0] == '0') {
   *f = f1;
   df[0] = 2*x[0];
   df[1] = 2*x[1];
   }
else {
   *f = f2;
   df[0] = 2*x[0]*x[1] + 1;
   df[1] = x[0]*x[0] - x[0];
}
*/
 *f = f1*(1-p1[0]) + f2*p1[0];
 df[0] = 2*x[0]*(1-p1[0]) + (2*x[0]*x[1] + 1)*p1[0];
 df[1] = 2*x[2]*(1-p1[0]) + (x[1]*x[1] - x[0])*p1[0];

}
