% script that shows the propagation of the 4-EM MTB pulses
%Y. Jaffal and A. Alvarado, Oct. 2022
close all;
clear all;
Wmax=50e9;
% The MTB pulses used for 4-EM in Figure 7 have energies 0.2pJ, 0.8pJ, and
% 1.8pJ. Each line in the following contains an energy and the
% corresponding duration. Uncomment only the line with the desired energy
%E=0.2e-12; Tp=280.5e-12;
E=0.8e-12; Tp=261e-12;
%E=1.8e-12; Tp=213e-12;

N=26;
epsilon=0.0001;
beta2=-2.17e-26; % -21.7 ps^2/Km
gamma=0.0012; % 1.2 /(W Km)
L=80e3; % fiber length
cp=10.5; % time bandwidth product of the used prolate spheroidal wave functions
load(strcat('results/Alphas_Lossless_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'));
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
%Normalize PSWFs to be unit norm
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
Yout=Yin;% pulse at distance zero
YoutVec=[Yin]; % Vector to save pulse at several distances
for iter=1:8
    Yout=LosslessChannel(Yout, t, beta2,gamma,L/8);% pulse at 10Km, 20Km, ...,80Km
    YoutVec=[YoutVec; Yout];
end
T = ComputeEffectiveDuration(Yout,t,epsilon);
B = ComputeEffectiveBandwidth(Yout,t,epsilon);
fprintf('Tp=%f ps, T~p=%f ps, W=%f GHz\n',Tp*1e12, T*1e12, B*1e-9)
figure(6);
selected_t=t(floor(2.8*M):500:floor(4.2*M));
selected_YoutVec=abs(YoutVec(:,floor(2.8*M):500:floor(4.2*M)));
[X,Y]=meshgrid(selected_t*1e12,0:10:80);
surf(X,Y,selected_YoutVec);
xlabel('time (ps)')
ylabel('Distance (Km)')
