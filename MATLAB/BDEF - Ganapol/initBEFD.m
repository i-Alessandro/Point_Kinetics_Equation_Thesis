function [T, N, color] = initBEFD(n,h)
    
    format long;
    [lambda, beta, L, rho_0, alpha, q,tmax] = cases(n);
    
    u_0 = [1; beta./(lambda*L);0];

    tmin = 0;
    
    n=ceil((tmax-tmin)/h);
    
    toll = 1e-10;
    T(1) = h;
    u(:,1) = u_0;
    R = [];
    
    for i = 2:(n) 
    
        T(i) = (i)*h;       

        rho = @(n, t) rho_0(t)+alpha*(sum(u(1,:)*h)+n*h);
    
        D = diag([-lambda; 0]);
        v = [lambda', 0];
        w = [beta/L; alpha];
        A = @(n,t) [(rho(n,t)-sum(beta))/L, v; w, D];
        
        
        F = @(y) -(eye(length(u_0)) - h*A(y(1),(i+1)*h))*y + u(:,i-1) + h*q;
        options = optimoptions('fsolve','TolFun', toll,'Display','off');        
    
        %Richardson Extrapolation
        u_0 = myRichardson_Benchmark_fun(A, T(i), q, u(:,i-1), h, 10, toll);
        u(:,i) = fsolve(F, u_0, options);

        R(i) = rho(u(1,i),i*h);

        round(i/n*100,2)
    
    end
    
    N = u(1,:);
    color = 'm';
end

