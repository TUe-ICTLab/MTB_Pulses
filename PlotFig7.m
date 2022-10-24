% This script plots figure 7 of the paper: 
%"Time-Limited Waveforms with Minimum Time Broadening for the Nonlinear
%Schrodinger Channel" by Y. Jaffal and A. Alvarado
%Y. Jaffal and A. Alvarado, Oct. 2022
close all;
figure(7);
% plot the results of MTB, dispersion-only
scatter([0.01],[285.56]);
% plot the results of MTB, lossless
fprintf('Plotting the MTB results for Lossless fiber...\n');
cd LosslessFiber;
Lossless_Results_Part_of_Fig7;
cd ..
% plot the results of MTB, lossy
cd LossyFiber;
fprintf('Plotting the MTB results for Lossy fiber...\n');
Lossy_Results_Part_of_Fig7
cd ..;
legend('MTB, dispersion-only', 'MTB, Lossless', 'MTB, Lossy')
