function y = piecewise_const(lambda, beta, beta_sum, L, target, h, rho, f_case, init_cond,rval, alpha)
% This function will calculate the solution to the point kinetics equation
% starting at time = 0. The following is a summary of the arguments for the
% function:
% lambda = a vector of the decay constants for the delayed neutrons
% beta = a vector containing the delayed-neutron fraction
% beta_sum = the sum of all of the betas
% L = neutron generation time
% target = the final, target time of the function
% h = step size
% f_case = similar to "rho_case" but it determines the source term
% to be used

% Determine the number of delay groups, thereby the size of our solution

m = length(lambda) + 1;
% Calculate the values of several constants that will be needed in
% the control of the iterations as well as set up some basic matrices.
x = init_cond; time = 0;
f_hat = zeros(m,1);
d_hat= zeros(m,m);
big_d = zeros(m,m);
i = 1;
iterations = target / h;
result = zeros(m+1,iterations);
% Begin time dependent iterations
d=rval;
while time < (target)
    time = time + h;
    % Calculate the values of the reactivity and source at the midpoint
    mid_time = time + (h)/2;

    rho_alpha = @(t) rho(t) + alpha*h*sum(result(2,:));

    p = rho_alpha(mid_time);
    source = f(f_case, mid_time);
    
    % Caculate the roots to the inhour equation
    d = inhour(lambda, L, beta, p, d);
    
    % Calculate the eigenvectors and the inverse of the matrix
    % of eigenvectors
    Y = ev2(lambda, L, beta, d);
    Y_inv = ev_inv(lambda, L, beta, d);
    
    % Construct matrices for computation
    for k = 1:m
        d_hat(k,k) = exp(d(k)*h);
        big_d(k,k) = d(k);
    end
    
    f_hat(1) = source;
    big_d_inv = zeros(m,m);
    for k =1:m
        big_d_inv(k,k) = 1/big_d(k,k);
    end
    
    % Compute next time step
    x = (Y * d_hat * Y_inv)*(x + (Y*big_d_inv*Y_inv*f_hat)) - (Y*big_d_inv*Y_inv*f_hat);
    
    % Store results in a matrix
    for j = 1:m
        result(1,i) = time;
        result(j+1,i) = x(j);
    end
    i/iterations*100
    % Update counters
    i = i + 1;
end

y=result;