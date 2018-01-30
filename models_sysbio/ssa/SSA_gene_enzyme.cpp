#include "mex.h"
#include <cmath>
#include <algorithm>
#include <omp.h>

// Input:   X (Three state vector)
// Input:   Omega
// Input:   tCurr
// Input:   tNext

// Output:  t - new time
// Output:  XCurr
// Output:  XSaved



void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    /*Check number of input arguments*/
    if(nrhs < 4 || nrhs > 4){
        mexErrMsgTxt("Wrong number of input arguments.");return;
    }else if(nlhs > 3){
        mexErrMsgTxt("Too many output arguments.");return;
    }
    
    /* Declare Inputs*/
    double *xCurr;
    double Omega;
    double tCurr;
    double tNext;

    
    /* Declare IMs*/
    double cumProps[6];
    
    /* Declare Outputs*/
    int    reactionIndex;
    double *xOut;
    double* xFin;
    
    /* Load input values from prhs */
    xCurr     = mxGetPr(prhs[0]);
    Omega = mxGetScalar(prhs[1]);
    tCurr = mxGetScalar(prhs[2]);
    tNext = mxGetScalar(prhs[3]);

    /* Create Outputs I */
    plhs[2] = mxCreateDoubleMatrix(3,1,mxREAL);
    xOut    = mxGetPr(plhs[2]);
    plhs[1] = mxCreateDoubleMatrix(3,1,mxREAL);
    xFin    = mxGetPr(plhs[1]);

    /* Declare theta without omega */
    double k2    = 1;
    double k0    = 2.25;
    double kdm   = 10;
    double ks    = 4;
    double k1    = 100;
    double km2   = 1;
    double cE0   = 1;
    double E0    = round(cE0 * Omega);//why round in original code?
    
    /* Start iteration*/    
    double rand1,rand2;
    while(tCurr < tNext)
    {
        double rand1 = (double)rand()/(double)RAND_MAX;
        double rand2 = (double)rand()/(double)RAND_MAX;
        
        /* Calculate cumulative propensities in one step*/
        cumProps[0] =               k0*Omega;
        cumProps[1] = cumProps[0] + kdm*xCurr[0];
        cumProps[2] = cumProps[1] + ks*xCurr[0];
        cumProps[3] = cumProps[2] + k1/Omega*xCurr[1]*xCurr[2];
        cumProps[4] = cumProps[3] + km2*(E0-xCurr[2]);
        cumProps[5] = cumProps[4] + k2*(E0-xCurr[2]);

        /* Sample reaction time*/
        tCurr = tCurr + 1/cumProps[5]*log(1/rand1);

        if(tCurr >= tNext)
        {
            xOut[0] = xCurr[0];
            xOut[1] = xCurr[1];
            xOut[2] = xCurr[2];
        }
        
        /* Sample reaction index*/
        double chosenProp = rand2 * cumProps[5];
        reactionIndex = 1;
        for(int i = 1; cumProps[i-1] <= chosenProp; /*mexPrintf("%f\t%f\n",cumProps[i],chosenProp),*/i++)
        {
            reactionIndex = i+1;
        }
        
        /* Update xCurr */ 
        switch(reactionIndex)
        {
             case 1: xCurr[0] = xCurr[0] + 1;break;
             case 2: xCurr[0] = xCurr[0] - 1;break;
             case 3: xCurr[1] = xCurr[1] + 1;break;
             case 4: xCurr[1] = xCurr[1] - 1;xCurr[2] = xCurr[2] - 1;break;
             case 5: xCurr[1] = xCurr[1] + 1;xCurr[2] = xCurr[2] + 1;break;
             case 6: xCurr[2] = xCurr[2] + 1;break;
        }
    }
    /* End iteration*/
    
    /* Return results*/
    /* Create output variables */
    plhs[0] = mxCreateDoubleScalar(tCurr);
    xFin[0] = xCurr[0];
    xFin[1] = xCurr[1];
    xFin[2] = xCurr[2];
}

