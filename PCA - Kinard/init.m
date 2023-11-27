clc;%close all
%Chao and Attard
beta = [0.000266; 0.001491; 0.001316; 0.002849; 0.000896; 0.000182];
beta_sum = sum(beta);
lambda = [0.0127; 0.0317; 0.155; 0.311; 1.4; 3.87];
L = 0.00002;

%{
Norbega Thermal Reactor
beta = [2.850e-4; 1.5975e-3; 1.410e-3; 3.0525e-3; 9.600e-4; 1.950e-4];
lambda = [0.0127; 0.0317; 0.115; 0.311; 1.40; 3.87];
beta_sum = sum(beta);
L = 5e-4;
%}

h = 0.01;
target = 0.02;
rho_case = 1;
f_case = 1;
init_cond = [1; beta./(L*lambda)];
rval = zeros(7,1);

y = piecewise_const(lambda, beta, beta_sum, L, target, h, rho_case, f_case, init_cond,rval);
t = y(1,:);
n = y(2,:);
c = y(3:7,:);
figure()
plot(t,n),grid,
xlabel('time'), ylabel('n')
figure()
plot(t,c(1,:))
xlabel('time'), ylabel('n')
