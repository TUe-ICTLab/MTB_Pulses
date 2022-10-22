
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
Evec=[1e-14  1e-13 2e-13 3e-13 5e-13 7e-13 8e-13 1e-12 1.2e-12 1.25e-12 1.3e-12 1.4e-12 1.5e-12 1.6e-12 1.7e-12 1.8e-12];
TpVec=[285.5 283.5 280.5 277   271   264   261   254   246.5     244    242.5   237     231.5   225     217     213]*1e-12;
cp=10.5;% Time bandwidth product of the used PSWFs. After some efforts and trying different values of cp, 
      % we found that cp=10.5 works for all the considered energies in Evec.
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

TpTildeVec=[];
for iter=1:length(Evec)
    Tp=TpVec(iter);
    E=Evec(iter);
    load(strcat('results/Alphas_Lossless_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'));
    TpTildeVec=[TpTildeVec results(end)];
end
figure(7);
hold on;
plot(Evec*1e12, max(TpVec,TpTildeVec)*1e12);
grid on;
xlabel('$E$(pJ)', 'interpreter', 'latex');
ylabel('Minimum of max$\{T_p,T_{\tilde{p}^*}\}$(ps)', 'interpreter', 'latex');