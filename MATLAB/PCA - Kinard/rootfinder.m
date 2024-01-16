function y = rootfinder(coeff, init, tol)
% This is a simple wrapper function that takes an coefficent vector
% and uses Newton's method to find all of the real roots of said poly
% The function takes advantage of Horner's method to deflate the poly
% at each step to expedite computation. The argument init is a vector
% of initial values that are used in Newton's method.

deg = length(coeff) - 1;
result = zeros(deg,1);
counter=1;
while deg > 1
result(counter) = newton(init(counter),coeff,tol) ;
coeff = myHorner(coeff, result(counter), deg) ;
deg = deg - 1;
counter = counter + 1;
end
result(counter) = -coeff(1)/coeff(2);
y = result; 
