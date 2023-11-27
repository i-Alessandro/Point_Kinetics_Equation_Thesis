function y = myDeriv(coeff)
% A simple function that calculates the derivative
% coefficient vector for a given polynomial.

deg = length(coeff);
if deg ~= 1
    result = zeros(1,deg - 1);
    for i= 1: (deg-1)
        result(i) = coeff(i+1) * i;
    end
end
if deg == 1
    result = 0;
end
y = result;