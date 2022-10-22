
%Y. Jaffal and A. Alvarado, Oct. 2022
L=80e3;
epsilon=1e-4;
beta2=-2.17e-26; % -21.7 ps^2/Km
gamma=0.0012; % 1.2 /(W Km)
N=26; % Number of used PSWFs

%For each energy in the following vector, we obtained the corresponding MTB
%pulse and its duration. We used the same steps that we used for the dispersion
%only channel. For more details please check the scripts 
%"Main" and "MainMTB" in the folder "DispersionOnly" 
Evec=[1e-14  5e-13 8e-13 1.25e-12 1.8e-12];
TpVec=[285.5 271   261   244      213]*1e-12;
cp=10.5;% Time bandwidth product of the used PSWFs. After some efforts and trying different values of cp, 
      % we found that cp=10.5 works for all the considered energies in Evec.
%% Get the PSWFs and their eigenvalues that are already saved in "data"
addpath('../data');
addpath('../Soliton/');
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

cVec=[];
for iter=1:length(Evec)
    Tp=TpVec(iter);
    E=Evec(iter);
    % obtain the coefficients of the PSWFs for the obtained MTB pulses
    load(strcat('results/Alphas_Lossless_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'));
    %% Construct thge signal and propagate it using the function "LossyChannel", then compute effective durations, effective bandwidths, and time bandwidth product
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
    Yout=LosslessChannel(Yin, t,  beta2,gamma,L);
    Wp= ComputeEffectiveBandwidth(Yin,t,epsilon);
    Wptilde= ComputeEffectiveBandwidth(Yout,t,epsilon);
    Tptilde= ComputeEffectiveDuration(Yout,t,epsilon);
    cVec=[cVec max(Tptilde,Tp)*max(Wptilde,Wp)];
end
figure(4);
hold on;
plot(Evec*1e12, cVec);
grid on;
xlabel('$E_s$(pJ)', 'interpreter', 'latex');
ylabel('Time bandwidth product');