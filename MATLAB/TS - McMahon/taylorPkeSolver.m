function [t,N, C,N_1, C_1] = taylorPkeSolver(LAMBDA, lambda, beta, y0, rho_0, t0,t_max, h, alpha)
    n = ceil((t_max-t0)/h);

    BETA = sum(beta);

    N = [y0(1), zeros(1, n-1)];
    C = [y0(2:end), zeros(length(y0)-1, n-1)];

    N_1 = [y0(1), zeros(1, n-1)];
    C_1 = [y0(2:end), zeros(length(y0)-1, n-1)];

    u_0 = y0;

    t(1) = t0;
    figure()
    
    %plot((1:n)*h, rho((1:n)*h))
    for i=2:n
        t(i) = i*h;
        
        rho = @(t) rho_0(t) + alpha*h*sum(N);
        rho1 = @(t) rho_0(t) + alpha*h*sum(N_1);

        D = diag([-lambda]);
        v = [lambda'];
        w = [beta/LAMBDA];
        A = @(h) [(rho(t(i)+h)-BETA)/LAMBDA, v; w, D];
        
        u_0 = [N(i-1);C(:,i-1)];

        u_01 = [N_1(i-1);C_1(:,i-1)];
        
        myRichardson(A, zeros(length(y0),1),[N_1(i-1);C_1(:,i-1)], h, 5, 1e-9);
 
        N(i) = (1+h*(rho(i*h)-BETA)/LAMBDA)*u_0(1) + h*sum(lambda.*u_0(2:end));
        C(:,i) = (h/LAMBDA*beta)*u_0(1) + (1-h*lambda).*u_0(2:end);
        
        
        N_1(i) = (1+h*(rho1(i*h)-BETA)/LAMBDA +h^2/2*(((rho1(i*h)-BETA)/LAMBDA)^2 + ...
                    sum(lambda.*beta/LAMBDA)))*u_01(1) + h*sum(lambda.*u_01(2:end)) + ...
                    h^2/2*((rho1(i*h)-BETA)/LAMBDA)*sum(lambda.*u_01(2:end)) - h^2/2*sum(lambda.^2.*u_01(2:end));

        C_1(:,i) = (h/LAMBDA*beta+h^2/2*((beta*(rho1(i*h)-BETA)/LAMBDA^2)-lambda.*beta/LAMBDA))*u_01(1)+...
                 (1-h*lambda-(h*lambda).^2/2).*u_01(2:end) + h^2/2*beta/LAMBDA*sum(lambda.*u_01(2:end));

        round(i/n*100,2)
    end
        
end
