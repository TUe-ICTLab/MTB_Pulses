function [c, ceq] = const16(x)
% A function that contains the constraints for cp=16, this is used by the
% 'fmincon' in 'FminconCall.m'
Lambdas =[1  1  1  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  9.999999e-01  9.999985e-01  9.999809e-01  9.997886e-01 ...
    9.980329e-01  9.850408e-01  9.139571e-01  6.798613e-01  3.192690e-01  8.633740e-02  1.534925e-02  2.112249e-03  2.449190e-04  2.478827e-05  ...
    2.228563e-06  1.799777e-07  1.316513e-08  8.780196e-10  5.368138e-11  3.022710e-12  1.573868e-13  7.604610e-15  3.420527e-16  1.436318e-17  ...
    5.645087e-19  2.081504e-20  7.216270e-22  2.356936e-23  7.265918e-25  2.117847e-26];

Lambdas=Lambdas(1:2:end);
Factor=90000;
epsilon=0.0001;
ceq=sum(x.^2)*Factor^2-1;
c = sum(Factor^2*x.^2.*(1-Lambdas(1:length(x))))-epsilon*sum(x.^2)*Factor^2;
end

