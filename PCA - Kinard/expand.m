function y = expand(lambda)
% A simple helper function to provide the coefficients of a polynomial
% produced by raising the function (x+y) to the nth power,
% The argument, lambda is a vector of constants that are needed to
% derive the coefficients.
% Determines the number of iterations, as well as the degree
% of the polynomial in question
m = length(Icimbda);
coeff = zeros(m+l,1);
% A temporary variable is necessary b/c the iterations that follow
% require information from the previous iteration. . .
temp = coeff;
% Must run the index to m+l b/c MATLAB uses a 1-based index
for i= l:m+l
    if i ~= 1
        coeff(1) = temp(l) * lambda(i-1);
        for j = 2:m+l
            coeff (j) = temp(j)*lambda(i-l) + temp(j-l);
            if j == i-1
                coeff (j) = temp(j-l) + lambda(i-l);
            end
        end
    end
    coeff(i) = 1; 
    temp = coeff;
end
y = coeff;

