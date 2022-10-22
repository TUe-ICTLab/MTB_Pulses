function [c, ceq] = const10(x)
% A function that contains the constraints for cp=10, this is used by the
% 'fmincon' in 'FminconCall.m'
Lambdas =[1.000000e+00  1.000000e+00  1.000000e+00  9.999999e-01  9.999963e-01  9.999331e-01  9.990734e-01  9.903467e-01  9.293000e-01  6.923413e-01 ...
    3.062372e-01  7.133448e-02  1.024160e-02  1.093465e-03  9.511443e-05  6.999379e-06  4.445816e-07  2.470882e-08  1.214254e-09  5.321299e-11  ...
    2.094480e-12  7.449868e-14  2.407471e-15  7.101871e-17  1.920548e-18  4.779462e-20  1.098354e-21  2.338263e-23  4.624843e-25  8.521587e-27  ...
    1.466373e-28  2.361962e-30  3.568960e-32  5.069036e-34  6.780220e-36  8.555916e-38  1.020277e-39  1.151548e-41 ];

Lambdas=Lambdas(1:2:end);
Factor=90000;
epsilon=0.0001;
ceq=sum(x.^2)*Factor^2-1;
c = sum(Factor^2*x.^2.*(1-Lambdas(1:length(x))))-epsilon*sum(x.^2)*Factor^2;
end

