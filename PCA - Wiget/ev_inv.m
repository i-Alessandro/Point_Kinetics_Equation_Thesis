function y = ev_inv(lambda, L, beta, evals)
% This function returns the inverse of the matrix of eigenvalues
% based on some computations provieded in Aboanber and Nahla.

m = length(lambda) + 1;

for i = 1:m-1
    mu(i) = beta(i)/L;
end

normfact = zeros(m,1);

for k = 1:m
    sum = 0;
    for i = 1:m-1
        temp= mu(i)*lambda(i);
        temp2 = (lambda(i) + evals(k))^2;
        temp3 = temp/temp2;
        sum = sum+temp3;
    end
normfact(k) = 1 / (sum+1); 
end

result = zeros(m,m); 
for i = 1:m
    for j = 1:m
        if i == 1
            result(i,j) = 1*normfact(j);
        end
        if i~=1
            result(i,j) = (lambda(i-1) / (lambda(i-1) + evals(j)))*normfact(j);
        end
    end
end
y=transpose(result);
