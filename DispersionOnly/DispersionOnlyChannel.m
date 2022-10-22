function [Yout] = DispersionOnlyChannel(Yin, t, beta2,L)
% Inputs: Yin:   input signal to the fiber
%         t:     corresponding time vector
%         beta2: dispesion parameter
%         L:     fiber length
% Output: Yout:  received signal at distance L
%Y. Jaffal and A. Alvarado, Oct. 2022
M=length(Yin);
dt=t(2)-t(1);
Fvec=linspace(-1/(2*dt),1/(2*dt),M);
Yf=fftshift(fft(Yin)); % Sf is the Fourier transform of Y
Yout=ifft(ifftshift(Yf.*exp(1i*2*pi^2*Fvec.^2*beta2*L))); 
end

