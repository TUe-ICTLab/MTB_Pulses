% This script constructs the MTB pulses for the distances 40Km, 80Km,
% 120Km, and 160 Km. And prints their duration and bandwidth, and the time
% bandwidth product
%Y. Jaffal and A. Alvarado, Oct. 2022
close all;
Wmax=50e9;
E=1e-14;
N=26;
epsilon=0.0001;
beta2=-2.17e-26; % -21.7 ps^2/Km
LVec=[40 80 120 160]*1e3; % diffent Distances
TpVec=[202 285.5 350 404]*1e-12; % corresponding duration of MTB pulses, example Tp=202ps for L=40Km,...
cpVec=[10 14 16 20]; % corresponding time bandwidth product of the used prolate spheroidal wave functions
for iter=1:4
    Tp=TpVec(iter);
    L=LVec(iter);
    cp=cpVec(iter);
    load(strcat('results/Alphas_DO_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'));
    %% Get the PSWFs and their eigenvalues that are already saved in "data"
    addpath('../data');
    PSWFs=[];    
    Lambdas=[]; 
    for n=0:2:N-1
        s=strcat(strcat(strcat('yS',strcat(num2str(cp),'n')),num2str(n)),'.mat');
        load(s);
        PSWFs=[PSWFs; yS];
        s=strcat(strcat(strcat('lambda',strcat(num2str(cp),'n')),num2str(n)),'.mat');
        load(s);
        Lambdas=[Lambdas lambda];
    end
    % Get the time vector, the signal will be appended with zero signal of
    % duration 3Tp on the left, and also 3Tp on the right
    Mys=length(yS);
    Tw = 7*Tp; %Total time window
    Ts = Tw/(7*Mys);% sample period 
    t = (-Tw/2:Ts:Tw/2-Ts);% time vector
    % Normalize PSWFs to be unit norm
    for n=1:N/2
        PSWFs(n,:)=PSWFs(n,:)/sqrt(sum(PSWFs(n,:).^2)*Ts);
    end
    % construct the pulse
    xin=results(1:end-1);
    xinit=sqrt(E)*xin/sqrt(sum(xin.^2));
    p=PSWFs(1,:)*xinit(1);
    for n=2:length(xinit)
        p=p+PSWFs(n,:)*xinit(n);
    end
    M=length(p);
    Yin=[zeros(1,3*M) p zeros(1,3*M)];%append p with zeros
    t=linspace(-Tw/2, Tw/2, length(Yin));
    Yout=DispersionOnlyChannel(Yin, t, beta2,L);
    B = ComputeEffectiveBandwidth(Yout,t,epsilon);
    T = ComputeEffectiveDuration(Yout,t,epsilon);
    fprintf('L=%fKm, Tp=%fps, T=%fps, B=%fGHz, c=%f\n',L*1e-3, Tp*1e12, T*1e12, B*1e-9, Tp*B);
end
