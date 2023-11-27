function C = C_calculation(R_k, S_k, C_prec)
    
    beta = Constants.beta;
    lambda = Constants.lambda;
    LAMBDA = Constants.LAMBDA;
    h = Constants.h;
    
    C = zeros(1, 6);

    for i=1:6
        b = beta(i);
        l = lambda(i);
        
        res = 0;
        for j=1:7
            res = res + R_k(j)*(exp(S_k(j)*h) - exp(-lambda(i)*h))/(S_k(i)+lambda(i));
        end

        res = res*beta(i)/LAMBDA;
        res = res + C_prec(i)*exp(-lambda(i)*h);

        C(i) = res;
        
    end
end