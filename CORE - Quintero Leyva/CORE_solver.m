function [t, N, C, C_dot, S_k, PP] = CORE_solver(y0, rho, t0, t_max, h)
    n = ceil((t_max-t0)/h);

    N = zeros(n, 1);
    C = zeros(n, 6);
    C_dot = zeros(n,6);

    N(1) = y0(1);
    C(1, :) = y0(2:7);
    C_dot(1, :) = y0(8:end);
    
    

    beta = Constants.beta;
    lambda = Constants.lambda;
    LAMBDA = Constants.LAMBDA;

    t = 0:h:t_max-h;

    for i = 2:(n)
        
        [S_k, PP] = inhour(lambda, LAMBDA, beta, rho(1));
        R_k = R_calculation(N(i-1), C_dot(i-1,:), S_k);

        N(i) = 0;
        for j = 1:7
            N(i) = N(i) + R_k(j)*exp(S_k(j)*h);
        end
       
        C(i,:) = C_calculation(R_k, S_k, C(i-1,:));
        
        for j = 1:6
            C_dot(i,j) = (beta(j)*N(i)/LAMBDA - lambda(j)*C(i,j));
            
        end      
    
    end

    %size(N)
    %size(t)
end