function [] = FminconCall(cp, N, E, Tp,beta2, L,epsilon)
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
%% Optimization
Factor=90000;% used to scale the coefficients of the PSWFs when calling the "fmincon" function, also in the functions "const"

load(strcat('results/Alphas_DO_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'));
xinit=results(1:end-1);% get initial point for the optimization from a previous results.
                       % You can also use: xinit=rand(1,N/2);
                       % The optimization should be performed sufficient times to make sure you find the global optimum 
xinit=xinit/sqrt(sum(xinit.^2))/Factor;
xinit=xinit.*ones(1,N/2);
OPTIONS = optimset('algorithm','sqp','Diagnostics','off','Display','iter','TolFun',1e-14, ...
    'TolX',1e-14,'MaxFunEvals',100000);
[v, TpTilde] = fmincon(@(x) DO_Func_TpTilde(x,beta2,L,PSWFs,Tw,E,Factor,epsilon), xinit, [], [], [], ...
   [], -1*ones(1,N/2)/Factor, ones(1,N/2)/Factor, strcat('const',num2str(cp)),OPTIONS); % Use the matlab function 'fmincon' to search for a solution
%% save results
if (sum(v.^2.*(1-Lambdas(1:length(v))))>epsilon*sum(v.^2))% check if constraint is satisfied
    TpTilde=NaN;
    return;
else 
    try %compare with previous result if it exists
        load(strcat('results/Alphas_DO_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'));
        if(results(end)>TpTilde*10^-9)% if new result is better than previous one, then update results
            results = [v*Factor TpTilde*10^-9];
            save(strcat('results/Alphas_DO_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'),'results');
        end
    catch
        results = [v*Factor TpTilde*10^-9]; % results(1:end-1) contains the obtained coefficients alpha, and results(end) contains the obtained TpTilde in ns
        save(strcat('results/Alphas_DO_E',num2str(E*1e15),'fJ_Tp',num2str(Tp*1e12),'ps_N', num2str(N),'cp',num2str(cp),'_L',num2str(L*1e-3),'Km.mat'),'results');
    end
end
end