function R_k = R_calculation(N, C_dot, S_k, beta, lambda, LAMBDA)
    R_k = zeros(1, length(S_k));
    for i = 1:length(S_k)     
        s1 = 0;
        for j=1:length(beta)
            add = beta(j)/(S_k(i) + lambda(j));
            s1 = s1 + add;
        end
        s1 = s1/LAMBDA;
        s1 = s1+1;


        s2 = 0;
        for j=1:length(beta)
            add = lambda(j)*beta(j)/(S_k(i) + lambda(j))^2;
            s2 = s2 + add;
        end
        s2 = s2/LAMBDA;
        s2 = s2+1;

        s3 = 0;
        for j=1:length(beta)
            s3 = s3 + C_dot(j)/(S_k(i)+lambda(j));
        end

        R_k(i) = (N*s1 - s3)/s2;
    end