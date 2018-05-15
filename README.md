# Study-DFO

An evaluation of the applicability of derivative-free optimization for parameter estimation in systems biology. Supplementary material for "Y. Schälte, P. Stapor, J. Hasenauer. Evaluation of Derivative-Free Optimizers for Parameter Estimation in Systems Biology. FOSBE, 2018."

### Requirements

* An installation of Matlab, version 2017a (used in the study) or higher.
* Some of the optimizers are contained in the Matlab Optimization and Global Optimization toolboxes.
* Some of the optimizers require a Fortran compiler to generate .mex files. Preferably use the compilers recommended by Matlab for your operating system, see [here](https://de.mathworks.com/help/matlab/write-fortran-mex-files.html).
* Some of the application examples require the [AMICI](https://github.com/ICB-DCM/AMICI) ODE solving environment. To compile the models using C++, a C/C++ compiler is required. Preferably use the compilers recommended by Matlab for your operating system, see [here](https://de.mathworks.com/help/matlab/write-cc-mex-files.html).
* For the application examples, the [PESTO](https://github.com/ICB-DCM/PESTO) parameter estimation toolbox was used.
* The used, adapted, versions of [AMICI](amici) and [PESTO](pesto) are included in the respective subfolders in this repository.

### Installation

* Clone this repository ``git clone https://github.com/icb-dcm/Study-DFO``.
* The scripts in tests_testfunction should run out-of-the-box. For the scripts in tests_sysbio relying on AMICI, [amici/installAMICI.m](amici/installAMICI.m) needs to be called once beforehand in the open Matlab session.
* All other required paths should be automatically set when running the respective scripts.

### Code organization and Usage

* Apart from the Matlab optimizers, all the open-source optimizers examined in this study are contained in the [algorithms](algorithms) folder.
* The test problems are in the folders [models_testfunction](models_testfunction) and [models_sysbio](models_sysbio), the first being for the classic optimization test problems, the second for the systems biology ODE application examples.
* The scripts and settings used for the tests are in the folders [tests_sysbio](tests_sysbio) and [tests_testfunction](tests_testfunction). Both of these folders contain res/results subfolders as well as images subfolders containing the most important results of the evaluation and visualizations thereof.
* To run the classic optimizaton tests, use the function ``tests_testfunction/runTests``, passing values for which optimizers to test and so on. To run the application examples, use ``tests_sysbio/test_XY``.

It should be fairly easy and is encouraged to add further optimizers and test problems to this comparison.