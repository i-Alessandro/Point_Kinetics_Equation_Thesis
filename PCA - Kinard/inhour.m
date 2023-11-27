function y = inhour(lambda, L, beta, rho , init_root)
% This function begins by taking the arguments and converting them into
% the correct m-degree polynomial inorder to take advantage of the given
% method of finding the roots of said polynomial.
m = length(lambda);
sum = zeros(m,1);
coeff = expand(lambda);
coeff_2 = zeros(m+2,1);

for i = 2:m+1
    coeff_2(i) = (rho)*coeff(i) - L*coeff(i-1);
end

coeff_2(1) = rho*coeff(1);
coeff_2(m+2) = -L * coeff(m+1);

for i = 1:m
    temp_lambda = trunc(lambda, i);
    temp = beta(i)* expand(temp_lambda);
    sum = temp + sum;
end

sum = -1*sum;
res = zeros(m+2,1);

for i =1:m
    res(i+1) = coeff_2(i+1) + sum(i);
end

res(1) = coeff_2(1);
res(m+2) = coeff_2(m+2);

e_vals = rootfinder(res, init_root, .00001);
y = e_vals;