function [c, ceq] = const20(x)
% A function that contains the constraints for cp=20, this is used by the
% 'fmincon' in 'FminconCall.m'
Lambdas =[1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00 ...
    1.000000e+00  1.000000e+00  9.999997e-01  9.999968e-01  9.999652e-01  9.996741e-01  9.973663e-01  9.821926e-01  9.067859e-01  6.744485e-01 ...
    3.248643e-01  9.341351e-02  1.812252e-02  2.764521e-03  3.599696e-04  4.141535e-05  4.281348e-06  4.018220e-07  3.449833e-08  2.725527e-09  ...
    1.991163e-10  1.350687e-11  8.537625e-13  5.044357e-14  2.793589e-15  1.453736e-16  7.124461e-18  3.294982e-19];


Lambdas=Lambdas(1:2:end);
Factor=90000;
epsilon=0.0001;
ceq=sum(x.^2)*Factor^2-1;
c = sum(Factor^2*x.^2.*(1-Lambdas(1:length(x))))-epsilon*sum(x.^2)*Factor^2;
end

