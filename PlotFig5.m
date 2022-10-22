% This script plots figure 5 of the paper: 
%"Time-Limited Waveforms with Minimum Time Broadening for the Nonlinear
%Schrodinger Channel" by Y. Jaffal and A. Alvarado
%Y. Jaffal and A. Alvarado, Oct. 2022
close all;
figure(5);
% plot the result of MTB, dispersion-only
cd DispersionOnly\;
DispersionOnly_Results_Fig5;
cd ..
legend('$T_{\tilde{p}^*}$', '$T_{\tilde{p}}=T_p$', 'interpreter', 'latex')