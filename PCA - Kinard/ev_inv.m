function y = ev_inv(lambda, L, beta, evals)
% This function returns the inverse of the matrix of eigenvalues
% based on some computations provieded in Aboanber and Nahla.

m = length(lambda) + 1;

for i = l:m-l
    mu(i) = beta(i)/L;
end

normfact = zeros(m,l);

for k = l:m
    sum = 0;
    for i = l:m-l
        temp= mu(i)*lambda(i);
        temp2 = (lambda(i) + evals(k))^2;
        temp3 = temp/temp2;
        sum = sum+temp3;
    end
normfact(k) = 1 / (sum+1); 
end

result = zeros(m,m); 
for i = l:m
    for j = l:m
        if i == 1
            result(i,j) = l*normfact(j);
        end
        if i~=l
            result(i,j) = (lambda(i-l) / (lambda(i-l) + evals(j)))*normfact(j);
        end
    end
end
y=transpose(result); 
