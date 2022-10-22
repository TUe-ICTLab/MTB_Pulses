function [c, ceq] = const18(x)
% A function that contains the constraints for cp=18, this is used by the
% 'fmincon' in 'FminconCall.m'
Lambdas =[1  1  1  1  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  9.999998e-01  9.999977e-01  ...
    9.999735e-01  9.997324e-01  9.976955e-01  9.835620e-01  9.101609e-01  6.769658e-01  3.222660e-01  9.007945e-02  1.678688e-02 ...
    2.442241e-03  3.015030e-04  3.270596e-05  3.171135e-06  2.777924e-07  2.215969e-08  1.619749e-09  1.090438e-10  6.790645e-12  ...
    3.926555e-13  2.115134e-14  1.064552e-15  5.019346e-17  2.222388e-18  9.260544e-20  3.638909e-21  1.350927e-22];

Lambdas=Lambdas(1:2:end);
Factor=90000;
epsilon=0.0001;
ceq=sum(x.^2)*Factor^2-1;
c = sum(Factor^2*x.^2.*(1-Lambdas(1:length(x))))-epsilon*sum(x.^2)*Factor^2;
end

