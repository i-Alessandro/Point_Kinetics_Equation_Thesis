function C = C_calculation(R_k, S_k, C_prec, h, beta, lambda, LAMBDA)  
    C = zeros(1, 6);
    for i=1:length(beta)     
        res = 0;
        for j=1:length(S_k)
            res = res + R_k(j)*(exp(S_k(j)*h) - exp(-lambda(i)*h))/(S_k(j)+lambda(i));
        end
        res = res*beta(i)/LAMBDA;
        res = res + C_prec(i)*exp(-lambda(i)*h);

        C(i) = res;
    end
end