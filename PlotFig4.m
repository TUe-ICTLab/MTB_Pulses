% This script plots figure 4 of the paper: 
%"Time-Limited Waveforms with Minimum Time Broadening for the Nonlinear
%Schrodinger Channel" by Y. Jaffal and A. Alvarado
%Y. Jaffal and A. Alvarado, Oct. 2022
close all;
figure(4);
fprintf('This may take few minutes \n');
%plot c_s=9.94
plot([0.01 1.8],[9.94 9.94]);
hold on;
% plot the soliton part
fprintf('Plotting the soliton part...\n');
cd Soliton;
Soliton_Results_Part_of_Fig4;
cd ..;
% plot the results of MTB, dispersion-only
scatter([0.01],[8.57]);
% plot the results of MTB, lossless
fprintf('Plotting the MTB results for Lossless fiber...\n');
cd LosslessFiber;
Lossless_Results_Part_of_Fig4;
cd ..
% plot the results of MTB, lossy
cd LossyFiber;
fprintf('Plotting the MTB results for Lossy fiber...\n');
Lossy_Results_Part_of_Fig4
cd ..;
legend('Solitons, $c_s=9.94$','Truncated solions, lossless',...
    'Truncated solions, lossy', 'MTB, dispersion-only', ...
    'MTB, Lossless', 'MTB, Lossy', 'interpreter', 'latex')
