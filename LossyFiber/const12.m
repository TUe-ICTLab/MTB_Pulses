function [c, ceq] = const12(x)
% A function that contains the constraints for cp=12, this is used by the
% 'fmincon' in 'FminconCall.m'

 Lambdas =[1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  9.999996e-01  9.999925e-01  9.998903e-01  9.987257e-01  9.884064e-01  9.233178e-01 ...
6.873160e-01  3.115081e-01  7.715697e-02  1.209874e-02  1.434688e-03  1.405806e-04  1.180680e-05  8.661274e-07  5.619865e-08  3.256061e-09  1.697494e-10 ...
 8.014059e-12  3.445131e-13  1.355011e-14  4.896652e-16  1.631980e-17  5.033499e-19  1.441150e-20  3.841163e-22  9.555673e-24  2.224075e-25  4.853959e-27  ...
 9.954120e-29  1.921815e-30  3.499539e-32  6.020608e-34  9.801592e-36 ];

Lambdas=Lambdas(1:2:end);
Factor=90000;
epsilon=0.0001;
ceq=sum(x.^2)*Factor^2-1;
c = sum(Factor^2*x.^2.*(1-Lambdas(1:length(x))))-epsilon*sum(x.^2)*Factor^2;
end

