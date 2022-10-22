function [TpTilde] = Lossless_Func_TpTilde(xin, beta2, gamma, L, PSWFs,Tw, E, Factor,epsilon)

%Y. Jaffal and A. Alvarado, Oct. 2022
xin=xin*Factor;
xinit=sqrt(E)*xin/sqrt(sum(xin.^2));
p=PSWFs(1,:)*xinit(1);
for n=2:length(xinit)
    p=p+PSWFs(n,:)*xinit(n);
end
M=length(p);
Yin=[zeros(1,3*M) p zeros(1,3*M)];%append p with zeros

t=linspace(-Tw/2, Tw/2, length(Yin));
Yout=LosslessChannel(Yin, t, beta2, gamma,L);

% Compute effective duration that contains (1-epsilon)*100% of the energy
% method uses binary search until start and end are close, then applies
% sequential search
StartP=1; EndP=floor(3.5*M);
while(EndP>StartP+5)
    MidP=floor(0.5*(StartP+EndP));
    if (sum(abs(Yout([1:MidP 7*M-MidP+1:7*M])).^2)/sum(abs(Yout).^2)>epsilon)
        EndP=MidP;
    else
        StartP=MidP;
    end
end
Index=StartP+2;
for index=EndP:-1:StartP
    if (sum(abs(Yout([1:index 7*M-index+1:7*M])).^2)/sum(abs(Yout).^2)<epsilon)
        Index=index;
        break;
    end
end
TpTilde=-2*t(Index)*10^9;%get result in nanoseconds
end