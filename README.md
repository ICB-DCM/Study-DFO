# Study-DFO

An evaluation of the applicability of derivative-free optimization for parameter estimation in systems biology. Supplementary material for:

> "Yannik Schälte, Paul Stapor, Jan Hasenauer. Evaluation of Derivative-Free Optimizers for Parameter Estimation in Systems Biology. FOSBE, 2018."

### Requirements

* An installation of Matlab, version 2017a or higher (in the study, 2017a was used, except for the algorithms from the Global Optimization Toolbox, which was only available for 2017b).
* Some of the optimizers are contained in the Matlab Optimization and Global Optimization toolboxes.
* Some of the optimizers require a Fortran compiler to generate .mex files. Preferably use the compilers recommended by Matlab for your operating system, see [here](https://de.mathworks.com/help/matlab/write-fortran-mex-files.html).
* Some of the application examples require the [AMICI](https://github.com/ICB-DCM/AMICI) ODE solving environment. To compile the models using C++, a C/C++ compiler is required. Preferably use the compilers recommended by Matlab for your operating system, see [here](https://de.mathworks.com/help/matlab/write-cc-mex-files.html).
* For the application examples, the [PESTO](https://github.com/ICB-DCM/PESTO) parameter estimation toolbox was used.
* The used versions of [AMICI](amici) and (adapted to admit all optimizers) [PESTO](pesto) are included in the respective subfolders in this repository.

### Installation

* Clone this repository ``git clone https://github.com/icb-dcm/Study-DFO``.
* The scripts in tests_testfunction should run out-of-the-box. For the scripts in tests_sysbio relying on AMICI, [amici/installAMICI.m](amici/installAMICI.m) needs to be called once beforehand in the open Matlab session.
* All other required paths should be automatically set when running the respective scripts.

### Code organization and Running Tests

* Apart from the Matlab optimizers, all the open-source optimizers examined in this study are contained in the [algorithms](algorithms) folder.
* The test problems are in the folders [models_testfunction](models_testfunction) and [models_sysbio](models_sysbio), the first being for the classic optimization test problems, the second for the systems biology ODE application examples. For the ODE examples, the differential equation model files, simulated or experimental data used, and the likelihood functions used as objective functions, are provided.
* The scripts and settings used for the tests are in the folders [tests_sysbio](tests_sysbio) and [tests_testfunction](tests_testfunction). Both of these folders contain res/results subfolders as well as images subfolders containing the most important results of the evaluation and visualizations thereof.
* Actually, the classic optimization test scripts create .mat files directly in the tests_testfunctions folder. In order not to distribute a multiple-gigabyte repository, we put all of these into a folder results_big and then applied [tests_testfunction/removeTraceFromResults.m](tests_testfunction/removeTraceFromResults.m) which creates .mat files reduced in size in a results subfolder. Only the results subfolder was included in the repository, the full results are however available on demand.
* To run the classic optimizaton tests, use the function ``tests_testfunction/runTests``, passing values for which optimizers to test and so on. To run the application examples, use ``tests_sysbio/test_XY``.

### Overview of used optimizers

Optimizer | Version | Literature | Type | Source
--- | --- | --- | --- | ---
BOBYQA | 2009 | Powell 2009 | local, model-based (quadratic approximation) | [link](https://www.mat.uc.pt/~zhang/software.html)
CMAES | 3.61beta | Hansen 1996 | global, evolutionary (with covariance adaptation) | [link](https://www.lri.fr/~hansen/cmaesintro.html)
DHC | 1.0 | De La Maza and Yuret 1994 | local, direct (dynamic hill climbing) | [link](https://www.github.com/icb-dcm/pesto)
DIRECT | 4.0 | Finkel 2003 | global, partitioning (dividing rectangles) | [link](https://ctk.math.ncsu.edu/Finkel_Direct/DirectUserGuide_pdf.pdf)
FMINCON | R2017A | Byrd et al. 2000 | local, gradient-based (interior point) | [link](https://www.mathworks.com/products/optimization.html)
FMINSEARCHBND | R2017A | Nelder and Mead 1965 | local, direct (simplices) | [link](https://www.mathworks.com/products/optimization.html)
GA | R2017B | Mitchell 1998 | global, evolutionary (genetic) | [link](https://www.mathworks.com/products/global-optimization.html)
IMFIL | 1.0 | Kelley 2011 | local, direct (implicit filtering) | [link](https://ctk.math.ncsu.edu/)
MCS | 2.0 | Huyer and Neumaier 1999 | global, partitioning (multivariate coordinate search) | [link](https://www.mat.univie.ac.at/~neum/software/mcs)
MEIGO-ESS | 03-07.2014 | Egea et al. 2014 | global, hybrid (enhanced scatter search) | [link](https://www.gingproc.iim.csic.es/meigo.html)
PARTICLESWARM | R2017B | Eberhardt and Kennedy 1995 | global, swarm-based (particle swarm) | [link](https://www.mathworks.com/products/global-optimization.html)
PATTERNSEARCH | R2017B | Torczon 1997 | local, direct (pattern search) | [link](https://www.mathworks.com/products/global-optimization.html)
PSWARM | 2.1 | Vaz and Vicente 2009 | global, swarm-based (particle swarm) | [link](https://www.norg.uminho.pt/aivaz/pswarm)
RCS | 1.0 | - | local, direct (randomized coordinate search) | [link](https://www.github.com/icb-dcm/pesto)
SIMULANNEALBND | R2017B | Kirkpatrick et al. 1983 | local, direct (simulated annealing) | [link](https://www.mathworks.com/products/global-optimzation.html)

It should be fairly easy and is encouraged to add further optimizers and test problems to this comparison.
