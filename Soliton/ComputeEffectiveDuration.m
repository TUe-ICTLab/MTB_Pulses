function [T] = ComputeEffectiveDuration(Y,t,epsilon)
%Inputs: Y is the Signal vector, t is the time vector, and epsilon is the
%        parameter used to compute the bandwidth and duration that contain
%        (1-epsilon)*100% of the energy of the signal Y

% Output: T is the duration that contains (1-epsilon)*100% of the energy
%Y. Jaffal and A. Alvarado, Oct. 2022


%% Compute effective duration that contains (1-epsilon)*100% of the energy
% method uses binary search until start and end are close, then applies
% sequential search
N=length(Y);
StartP=1; EndP=floor(0.5*N);
% binay search
while(EndP>StartP+5)
    MidP=floor(0.5*(StartP+EndP));
    if (sum(abs(Y([1:MidP N-MidP+1:N])).^2)/sum(abs(Y).^2)>epsilon)
        EndP=MidP;
    else
        StartP=MidP;
    end
end
% sequential search
Index=StartP+2;
for index=EndP:-1:StartP
    if (sum(abs(Y([1:index N-index+1:N])).^2)/sum(abs(Y).^2)<epsilon)
        Index=index;
        break;
    end
end
T=-2*t(Index);

end