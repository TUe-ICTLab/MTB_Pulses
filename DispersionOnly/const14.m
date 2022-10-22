function [c, ceq] = const14(x)
% A function that contains the constraints for cp=14, this is used by the
% 'fmincon' in 'FminconCall.m'
 Lambdas=[1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  9.999992e-01  9.999873e-01  9.998416e-01 ...
 9.983771e-01  9.866476e-01  9.182879e-01  6.832520e-01  3.157472e-01  8.208093e-02  1.379323e-02  1.775664e-03  1.909518e-04  1.777943e-05  1.459491e-06 ...
 1.068776e-07  7.043675e-09  4.207268e-10  2.291049e-11  1.143073e-12  5.248169e-14  2.225885e-15  8.750790e-17  3.198774e-18  1.090262e-19  3.473794e-21 ...
 1.037121e-22  2.907735e-24  7.671143e-26  1.907942e-27  4.481632e-29  9.958446e-31 ];


Lambdas=Lambdas(1:2:end);
Factor=90000;
epsilon=0.0001;
ceq=sum(x.^2)*Factor^2-1;
c = sum(Factor^2*x.^2.*(1-Lambdas(1:length(x))))-epsilon*sum(x.^2)*Factor^2;
end

