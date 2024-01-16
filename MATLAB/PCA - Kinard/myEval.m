function y = myEval(coeff, x)
% Evaluates the polynomial expressed as coeff at the value x.
deg = length(coeff);
sum = coeff (1) ;
if deg ~=1
    for i = 2:deg
        sum = sum + coeff(i) * x^(i-1);
    end
end
y = sum; 
