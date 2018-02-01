if ~exist('amiwrap.m','file')
    error('The AMICI ODE integration toolbox must be installed.');
end

cd 'jakstat_signaling';
amiwrap('jakstat_pesto','jakstat_pesto_syms');

cd '../Pom1p_gradient_formation/Models';
run Pom1p_AP_wrap.m;

cd '../../RafMekErk';
amiwrap('rafMekErk_pesto','rafMekErk_pesto_syms');

cd '..';