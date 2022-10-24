function [Yout] = LosslessChannel(Yin, t, beta2,gamma,L)
% This function uses the adaptive split step Fourier method
% Inputs: Yin:   input signal to the fiber
%         t:     corresponding time vector
%         beta2: dispesion parameter
%         gamma: nonlinear parameter
%         L:     fiber length
% Output: Yout:  received signal at distance L
%Y. Jaffal and A. Alvarado, Oct. 2022

NLphiMax=0.005;
zcum=0;
stop=0;
%precision = @(x)double(x);
%dataFunc = @(x)gpuArray(precision(x));
%Yin=dataFunc(Yin);
PeakPow=max(sum(abs(Yin).^2));
dz=NLphiMax/(gamma*PeakPow);

M=length(Yin);
dt=t(2)-t(1);
%Fvec=dataFunc(linspace(-1/(2*dt),1/(2*dt),M));
Fvec=linspace(-1/(2*dt),1/(2*dt),M);
Yout=Yin;


while ~stop
    if (L-zcum)>dz
        zcum=zcum+dz;
    else
        dz=L-zcum;
        zcum=L;
        stop=1;
    end
    %% Dispersion operator
    Yf=fftshift(fft(Yout)); % Yf is the Fourier transform of Yout
    Yout=ifft(ifftshift(Yf.*exp(1i*2*pi^2*Fvec.^2*beta2*dz))); 
    %% Nonlinear operator
    N=dz*1i*gamma*(abs(Yout).^2);                     
    Yout=Yout.*exp(N);
    %% New step size
    PeakPow=max(abs(Yout).^2);
    dz=NLphiMax/(gamma*PeakPow);
end


end
