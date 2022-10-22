function [B] = ComputeEffectiveBandwidth(Y,t,epsilon)
%Inputs: Y is the Signal vector, t is the time vector, and epsilon is the
%        parameter used to compute the bandwidth and duration that contain
%        (1-epsilon)*100% of the energy of the signal Y

% Output: B is the bandwidth that contains (1-epsilon)*100% of the energy
%Y. Jaffal and A. Alvarado, Oct. 2022

%% Compute effective bandwidth that contains (1-epsilon)*100% of the energy
% method uses binary search until start and end are close, then applies
% sequential search
N=length(Y);
dt=t(2)-t(1);
E=sum(abs(Y).^2)*dt;
Fvec=linspace(-1/(2*dt),1/(2*dt),N);
df=Fvec(2)-Fvec(1);
Sf=fftshift(fft(Y)*dt); % Sf is the Fourier transform of Y

% binay search
StartP=1; EndP=floor(0.5*N);
while(EndP>StartP+5)
    MidP=floor(0.5*(StartP+EndP));
    if (sum(abs(Sf([1:MidP N-MidP+1:N])).^2)*df/E>epsilon)
        EndP=MidP;
    else
        StartP=MidP;
    end
end
% sequential search
Index=StartP+2;
for index=EndP:-1:StartP
    if (sum(abs(Sf([1:index N-index+1:N])).^2)*df/E<epsilon)
        Index=index;
        break;
    end
end
B=-2*Fvec(Index);

end