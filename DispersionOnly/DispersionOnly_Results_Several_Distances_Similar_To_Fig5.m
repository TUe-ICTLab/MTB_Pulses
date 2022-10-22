%Y. Jaffal and A. Alvarado, Oct. 2022
close all;
Wmax=50e9;
E=1e-14;
N=26;
beta2=-2.17e-26; % -21.7 ps^2/Km
for L=[40:40:160]*1e3
cpVec=[10:2:22];
TpTildeVec=[];
TpVec=[];
for cp=cpVec
    try
    Tp=cp/Wmax;
    load(strcat('results/Alphas_DO_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'));
    TpTildeVec=[TpTildeVec results(end)*1e12];
    TpVec=[TpVec Tp*1e12];
    catch
    end
end
figure(50)
hold on;
plot(TpVec,TpTildeVec,'-sq')
grid on
plot([min(TpTildeVec) max(TpVec)], [min(TpTildeVec) max(TpVec)],'-.')
xlabel('$T_p$(ps)', 'interpreter', 'latex')
ylabel('$T_{\tilde{p}}$(ps)', 'interpreter', 'latex')
legend('$T_{\tilde{p}^*}$','$T_{\tilde{p}}=T_p$', 'interpreter', 'latex')
end