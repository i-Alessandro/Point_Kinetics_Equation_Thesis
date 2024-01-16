
function Benchmark_BEFD(n)
    clc; close all;
    format long;
    [lambda, beta, L, rho_0, alpha, q] = cases(n);
    sum(beta)
    u_0 = [1; beta./(lambda*L);0];
    

    h = 0.001;
    tmin = 0;
    tmax = 20;
    n=ceil((tmax-tmin)/h);
    
    toll = 1e-14;
    T(1) = 0;
    u(:,1) = u_0;
    
    
    for i = 2:(n)    
        T(i) = (i)*h;       
    
        rho = @(n, t) rho_0(t)+alpha*(sum(u(1,:)*h)+n*h);

        aa = @(h) [1; h*beta/L./(1+h*lambda); h*alpha];
        bb = @(h) [1; h*lambda./(1+h*lambda); 0]';
        sigma = @(y, t, h) 1-(h*(rho(y,t)))/L+sum(h*beta./(1+h*lambda))/L;
        CC = @(h) diag([0; 1./(1+h*lambda); 1]);
        invA = @(y,t,h) aa(h)*bb(h)/sigma(y,t+h,h) + CC(h);
        
        F = @(y, h) invA(y(1), (i+1)*h, h)*(y + h*q);
        
        
        u_0 = myRichardson_Benchmark(F, T(i), q, u(:,i-1), h, 0, toll);
        u(:,i) = F(u_0,h);

        round(i/n*100,2)    
    end
    
    figure()
    loglog(T, u(1,:))
end

