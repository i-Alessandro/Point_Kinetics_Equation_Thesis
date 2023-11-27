function y = expand(lambda)
% A simple helper function to provide the coefficients of a polynomial
% produced by raising the function (x+y) to the nth power,
% The argument, lambda is a vector of constants that are needed to
% derive the coefficients.
% Determines the number of iterations, as well as the degree
% of the polynomial in question
m = length(lambda);%m = length(Icimbda);
coeff = zeros(m+1,1);
% A temporary variable is necessary b/c the iterations that follow
% require information from the previous iteration. . .
temp = coeff;
% Must run the index to m+l b/c MATLAB uses a 1-based index
for i= 1:m+1
    if i ~= 1
        coeff(1) = temp(1) * lambda(i-1);
        for j = 2:m+1
            coeff (j) = temp(j)*lambda(i-1) + temp(j-1);
            if j == i-1
                coeff (j) = temp(j-1) + lambda(i-1);
            end
        end
    end
    coeff(i) = 1; 
    temp = coeff;
end
y = coeff;

