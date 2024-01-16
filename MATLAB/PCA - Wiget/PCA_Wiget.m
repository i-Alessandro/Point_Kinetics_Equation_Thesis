%clc; close all; clear;
format long


%Step Insertion of rho = 0.003
beta = [0.000266; 0.001491; 0.001316; 0.002849; 0.000896; 0.000182];
beta_sum = sum(beta);
lambda = [0.0127; 0.0317; 0.155; 0.311; 1.4; 3.87];
L = 0.00002;

rho_init = 0.003;
rho_0 = @(t) rho_init;

alpha = 0;
q = zeros(7,1);


%{
%Ramp Insertion of 0.1$
lambda = [1.27e-3; 3.17e-2; 1.15e-1; 3.11e-1; 1.4; 3.87];
beta = [266e-6; 1491e-6; 1316e-6; 2849e-6; 896e-6; 182e-6];
L = 2e-5;

rho_init = 0.007*0.1;
rho_0 = @(t) rho_init*t;

alpha = 0;
q = zeros(8,1);
%}

%{
%Sinusoidal Insertion T=50, rho_0 = 0.0053333
beta = 0.0079;
lambda = 0.077;
L = 1e-8;

rho_init = 0.0053333;
T=250;
rho_0 = @(t) rho_init*sin(pi*t/T);

alpha = 0;
q = zeros(3,1);
%}

%{
%Step Insertion of rho = 0.007 with feedback
lambda = [1.24e-3; 3.05e-2; 1.11e-1; 3.01e-1; 1.13; 3];
beta = [2.1e-4; 1.41e-3; 1.27e-3; 2.55e-3; 7.4e-4; 2.7e-4];
L = 5e-5;

rho_init = sum(beta)*0.1;
rho_0 = @(t) rho_init;

alpha = -2.5*1e-6;
q = zeros(8,1);
%}

%{
%Ramp Insertion of 0.1$ with feedback
lambda = [1.24e-3; 3.05e-2; 1.11e-1; 3.01e-1; 1.13; 3];
beta = [2.1e-4; 1.41e-3; 1.27e-3; 2.55e-3; 7.4e-4; 2.7e-4];
L = 5e-5;

rho_init = sum(beta)*0.1;
rho_0 = @(t) rho_init*t;

alpha = -2.5*1e-6;
q = zeros(8,1);
%}


%{
%Benchmark
lambda = [1.26e-3; 3.17e-2; 1.15e-1; 3.11e-1; 1.4; 3.87];
beta = [266e-6; 1491e-6; 1316e-6; 2849e-6; 896e-6; 182e-6];
L = 5e-5;

rho_init = 0.1;
rho_0 = @(t) rho_init*t;

alpha = -1e-11;
q = zeros(8,1);
%}

tmin = 0;
tmax = 2;
h = 1;
n=ceil((tmax-tmin)/h);

T(1) = h;
u(:,1) = [1; beta./(lambda*L)];

for i = 2:n
    T(i) = h*i;

    rho = @(n, t) rho_0(t)+alpha*(sum(u(:,i-1)*h)+n);

    r = 0.1*0.007*h*i;%rho(u(1,i-1), h*(i+0.5));

    S_k = inhour(lambda, L, beta, r)
    S_k = S_k(end:-1:1);
    %
    tt = [-200.7647; -3.72268; -1.14757; -0.16620; 0.12353; -0.49175; -0.13513]; 
    D = diag(S_k);
    expD = diag(exp(S_k));
    
    for l = 1:7
        aa(l) = check(lambda, beta, L, 0.003, S_k(l));
        bb(l) = check(lambda, beta, L, 0.003, tt(l));
    end

    aa
    bb

    for k = 1:length(S_k)
        for j = 1:7
            if j==1
                X(j, k) = 1;
                invX(j,k) = 1/normf; 
            else
                X(j, k) = beta(j-1)/(L*(lambda(j-1)+S_k(k)));
                invX(j,k) = lambda(j-1)/(lambda(j-1)+S_k(k))/normf;
            end
        end
    end
    invX = ev_inv(lambda, L, beta, S_k)

    u(:,i) = X*expD*invX*u(:,i-1); %+ (X*expD*invX - eye(7))*X*(1./D)*invX*q;
    i/n*100
end

plot(linspace(tmin, tmax, n), u(1,:));

S_k
