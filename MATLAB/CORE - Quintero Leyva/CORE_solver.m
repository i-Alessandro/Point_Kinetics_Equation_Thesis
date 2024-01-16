function [t, N, C, C_dot, S_k] = CORE_solver(y0, rho_0, t0, t_max, h, beta,lambda,LAMBDA,alpha)
    n = ceil((t_max-t0)/h);
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\PCA - Kinard')
    N = zeros(n, 1);
    C = zeros(n, 6);
    C_dot = zeros(n,6);

    N(1) = y0(1);
    C(1, :) = y0(2:7);
    C_dot(1, :) = y0(8:end);

    t = 0:h:t_max;

    for i = 2:(n+1)

        rho = @(t) rho_0(t) + alpha*h*sum(N);

        C_dot(i,:) = (beta./LAMBDA)'*N(i-1) - lambda'.*C(i-1,:);

        S_k = inhour(lambda, LAMBDA, beta, rho(i*h), zeros(length(beta)+1,1));

        R_k = R_calculation(N(i-1), C_dot(i,:), S_k, beta, lambda, LAMBDA);
        R_k = R_k';
        
        N(i) = sum(R_k.*exp(S_k*h));
       
        C(i,:) = C_calculation(R_k, S_k, C(i-1,:), h, beta, lambda, LAMBDA);

        ceil(i/n*100)
    
    end
end







  
