function [t,n,color]=initPCA(n,h)

addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\BDEF - Ganapol')

[lambda, beta, L, rho, alpha, q,tmax] = cases(n);
beta_sum = sum(beta);

f_case = 1;
init_cond = [1; beta./(L*lambda)];
rval = zeros(length(beta)+1,1);

y = piecewise_const(lambda, beta, beta_sum, L, tmax, h, rho, f_case, init_cond,rval, alpha);
t = y(1,:);
n = y(2,:);
c = y(3:end,:);

color = 'b';

end
