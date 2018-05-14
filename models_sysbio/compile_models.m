cd 'Histones';
amiwrap('histonesPre','histones_preequ_Zheng_syms');
amiwrap('histones','histones_Zheng_syms');

cd '../hopfbifurcation';
amiwrap('hopfbifurcation','hopfbifurcation_syms');

cd '../jakstat_small/models';
amiwrap('jakstat_standard','jakstat_standard_syms');

cd '../../Pom1p_gradient_formation/Models';
Pom1p_MSP_wrap;

cd '../../rafmekerk/models';
amiwrap('rafmekerk_standard','rafmekerk_standard_syms');

