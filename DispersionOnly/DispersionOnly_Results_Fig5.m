Wmax=50e9;
E=1e-14;
N=26;
beta2=-2.17e-26; % -21.7 ps^2/Km
L=80*1e3; % Fiber length (m)
cpVec=[10:2:20];
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
figure(5)
hold on;
plot(TpVec,TpTildeVec,'-sq')
grid on
plot([260 330], [260 330],'-.')
xlabel('$T_p$(ps)', 'interpreter', 'latex')
ylabel('$T_{\tilde{p}}$(ps)', 'interpreter', 'latex')