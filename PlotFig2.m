% This script plots figure 2 of the paper: 
%"Time-Limited Waveforms with Minimum Time Broadening for the Nonlinear
%Schrodinger Channel" by Y. Jaffal and A. Alvarado
%Y. Jaffal and A. Alvarado, Oct. 2022
close all;
addpath('Soliton');
addpath('LosslessFiber');
addpath('LossyFiber');
% Fibre parameters
L=80e3; % Length of fiber
beta2=-2.17e-26; % -21.7 ps^2/Km
gamma=0.0012; % 1.2 /(W Km)
alpha=0.2/(10/log(10))/1e3; %0.2dB/Km
epsilon=0.0001;
TsVec=[]; % Effective duration of soliton. Computed using equation (19)
TtpVecLossy=[]; % Effective duration of received signal when sending a truncated soliton over a lossy fiber
TtpVecLossless=[];% Effective duration of received signal when sending a truncated soliton over a lossy fiber
Evec=[0.01 0.05 0.1:0.1:1.8]*1e-12;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for E=Evec
    A=E/2*sqrt(gamma/abs(beta2));% compute A based on E, using equation (18)
    Ts=sqrt(abs(beta2))/A/sqrt(gamma)*log((2-epsilon)/epsilon); % Compute effective duration of soliton using equation (19)
    t=linspace(-Ts/2, Ts/2, 2^10+1);% generate time vector
    soliton=A*sech(A*sqrt(gamma/abs(beta2))*t);% compute the soliton using equation (17)
    M=length(soliton);
    
    Yin=[zeros(1,5*M) soliton zeros(1,5*M)]; % zero padding of the signal before 
    TY=linspace(-11*Ts/2,11*Ts/2,11*length(soliton));  % Time vector for the zero-padded truncated soliton
    YoutLossy=LossyChannel(Yin, TY,alpha, beta2,gamma,L); % Compute the received signal over a lossy fiber
    YoutLossless=LosslessChannel(Yin, TY, beta2,gamma,L); % Compute the received signal over a lossless fiber
    Tlossy=ComputeEffectiveDuration(YoutLossy,TY,epsilon); % Compute the efective duration of the received signal over a lossy fiber
    Tlossless=ComputeEffectiveDuration(YoutLossless,TY,epsilon);% Compute the efective duration of the received signal over a lossless fiber
    % save the computed durations in the following vectors
    TsVec=[TsVec Ts];
    TtpVecLossy=[TtpVecLossy Tlossy];
    TtpVecLossless=[TtpVecLossless Tlossless];
    fprintf('E=%fpJ, Tp=%fps, Tlossy=%fps, Tlossless=%fps\n',E*1e12, Ts*1e12, Tlossy*1e12, Tlossless*1e12);

end
figure(2);
semilogy(Evec*1e12, TsVec*1e12);
hold on;
semilogy(Evec*1e12, TtpVecLossless*1e12,'--');
semilogy(Evec*1e12, TtpVecLossy*1e12,'-.');
grid on;
xlabel('E(pJ)');
ylabel('Duration(ps)')
legend('$T_s$', '$T_{\tilde{s}}$, Lossless fiber', '$T_{\tilde{s}}$, Lossy fiber', 'interpreter', 'latex')
