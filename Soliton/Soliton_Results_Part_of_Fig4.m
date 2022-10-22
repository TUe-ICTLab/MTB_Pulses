% This script plots the soliton part of figure 4 of the paper: 
%"Time-Limited Waveforms with Minimum Time Broadening for the Nonlinear
%Schrodinger Channel" by Y. Jaffal and A. Alvarado
%Y. Jaffal and A. Alvarado, Oct. 2022

addpath('../LosslessFiber');
addpath('../LossyFiber');
% Fibre parameters
L=80e3; % Length of fiber
beta2=-2.17e-26; % -21.7 ps^2/Km
gamma=0.0012; % 1.2 /(W Km)
alpha=0.2/(10/log(10))/1e3; %0.2dB/Km
epsilon=0.0001;
Evec=[0.01 0.4 0.8 0.9 1.2 1.5 1.8]*1e-12;% Used energy levels in Fig. 4
TBproductLossy=[]; % Vector for the time bandwidth product of truncated soliton over a lossy fiber
TBproductLossless=[];% Vector for the time bandwidth product of truncated soliton over a lossless fiber
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
    BTruncatedSoliton=ComputeEffectiveBandwidth(Yin,TY,epsilon);% Compute the efective bandwidth of the truncated soliton
    Tlossy=ComputeEffectiveDuration(YoutLossy,TY,epsilon); % Compute the efective duration of the received signal over a lossy fiber
    Tlossless=ComputeEffectiveDuration(YoutLossless,TY,epsilon);% Compute the efective duration of the received signal over a lossless fiber
    Blossy=ComputeEffectiveBandwidth(YoutLossy,TY,epsilon); % Compute the efective bandwidth of the received signal over a lossy fiber
    Blossless=ComputeEffectiveBandwidth(YoutLossless,TY,epsilon);% Compute the efective bandwidth of the received signal over a lossless fiber
    % Compute and save the time bandwidth products 
    TBproductLossy=[TBproductLossy max(Ts,Tlossy)*max(BTruncatedSoliton,Blossy)];
    TBproductLossless=[TBproductLossless max(Ts,Tlossless)*max(BTruncatedSoliton,Blossless)];

end
figure(4);
plot(Evec*1e12, TBproductLossless);
hold on;
plot(Evec*1e12, TBproductLossy);
grid on;
xlabel('E(pJ)');
ylabel('Time-Bandwidth product')
