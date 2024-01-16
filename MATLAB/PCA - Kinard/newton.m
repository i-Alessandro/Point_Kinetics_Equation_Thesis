function y = newton(val, poly, tol)
% A simple implementation of Newton's Method
eps = 1;
x = val;
deriv = myDeriv(poly);
while eps > tol
temp = x - (myEval(poly,x) / myEval(deriv, x));
eps = abs(x - temp);
x = temp;
end 
y = x; 