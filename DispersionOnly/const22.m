function [c, ceq] = const22(x)
% A function that contains the constraints for cp=22, this is used by the
% 'fmincon' in 'FminconCall.m'
Lambdas =[1  1  1  1  1  1  1  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  1.000000e+00  9.999996e-01  ...
    9.999956e-01  9.999562e-01  9.996142e-01  9.970459e-01  9.809172e-01  9.037513e-01  6.722283e-01  3.271504e-01  9.641647e-02  1.936955e-02 ...
    3.078594e-03  4.197644e-04  5.081213e-05  5.551309e-06  5.529342e-07  5.057801e-08  4.272999e-09  3.349734e-10  2.446242e-11  1.669813e-12  ...
    1.068562e-13  6.427378e-15  3.642428e-16 ];

epsilon=0.0001;
Lambdas=Lambdas(1:2:end);
Factor=90000;
ceq=sum(x.^2)*Factor^2-1;
c = sum(Factor^2*x.^2.*(1-Lambdas(1:length(x))))-epsilon*sum(x.^2)*Factor^2;
end

