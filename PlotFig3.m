% This script plots figure 3 of the paper: 
%"Time-Limited Waveforms with Minimum Time Broadening for the Nonlinear
%Schrodinger Channel" by Y. Jaffal and A. Alvarado
%Y. Jaffal and A. Alvarado, Oct. 2022
close all;
% Fibre parameters
beta2=-2.17e-26; % -21.7 ps^2/Km
gamma=0.0012; % 1.2 /(W Km)
alpha=0.2/(10/log(10))/1e3; %0.2dB/Km
epsilon=0.0001;
Evec=[0.2 0.8 1.8]*1e-12; % Used energy levels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
for E=Evec
    A=E/2*sqrt(gamma/abs(beta2)); % compute A based on E, using equation (18)
    Ts=sqrt(abs(beta2))/A/sqrt(gamma)*log((2-epsilon)/epsilon); % Compute effective duration of soliton using equation (19)
    t=linspace(-Ts/2, Ts/2, 2^10+1);% generate time vector
    soliton=A*sech(A*sqrt(gamma/abs(beta2))*t); % compute the soliton using equation (17)
    semilogy(t*1e12,soliton);% plot the solitons, time axis in ps
    hold on;
end
grid on;
xlabel('t(ps)');
legend('$E_2=0.2$pJ', '$E_3=0.8$pJ', '$E_4=1.8$pJ', 'interpreter', 'latex')
