clc; close all; clear;
%L'algoritmo BEDF qui presentato è stato estrapolato dal paper scientifico:
%"A highly accurate algorithm for the solution od the point kinetics
%equations" di B.D. Ganapol, 2013
format long
%--------------------------------Costanti----------------------------------
%GANAPOL
%lambda = [0.0127; 0.0317; 0.115; 0.311; 1.4; 3.87];
%beta = [0.000285; 0.0015975; 0.001410; 0.0030525; 0.00096; 0.000195];
lambda = [0.0127; 0.0317; 0.115; 0.311; 1.4; 3.87];
beta = [0.000266; 0.001491; 0.001316; 0.002849; 0.000896; 0.000182];

BETA = sum(beta);
LAMBDA = 0.00002;
B = 0;
rho_0  = 0.003;
N_0 = 1;
u_0 = [N_0; beta./(LAMBDA*lambda)*N_0; rho_0];



%--------------------------Variabili del Metodo----------------------------

tmin = 0;
tmax = 1;
delta = 0.01;

%----------------------------------Set Up----------------------------------
rho = @(t) rho_0;
%{
sigma = @(t, h) 1 - h*rho(t)/LAMBDA + h/LAMBDA*beta'*(1./(1+h*lambda));

MAT = @(t,h) (1/sigma(t,h))*[1; (h/LAMBDA)*(beta./(1+h*lambda)); -h*B]*[1, (h*lambda./(1+h*lambda))', 0]...
             +diag([0; 1./(1+lambda); 1]);
%}
q = zeros(8,1);

D = diag([-lambda; 0]);
v = [lambda', 0];
w = [beta/LAMBDA; -B];
A = [(rho_0-BETA)/LAMBDA, v; w, D];

aa = @(h) [1; h*beta/LAMBDA./(1+h*lambda); -h*B];
bb = @(h) [1; h*lambda./(1+h*lambda); 0]';
sigma = @(h) [1-(h*(rho_0))/LAMBDA+sum(h*beta./(1+h*lambda))/LAMBDA];
CC = @(h) diag([0; 1./(1+h*lambda); 1]);

invA = @(h) aa(h)*bb(h)/sigma(h) + CC(h);

%------------------------------Punto Fisso---------------------------------
s = 10;
T = tmin:delta:tmax;
n = length(T);
m = length(u_0);

u = zeros(m,n);
u(:,1) = u_0;

toll = 1e-10;

for i = 2:(n) 
    %{
    F = @(y) -(eye(length(u_0)) - delta*A)*y + u_0 + delta*q;
    options = optimoptions('fsolve','TolFun', toll);
    u(:,i) = fsolve(F, u_0, options);
    %}
    u(:,i) = invA(delta)*(u_0+delta*q);

    %Richardson Extrapolation
    u_0 = myRichardson(invA, q, u(:,i), delta, 14, toll);  
end

plot(T, u(1,:))




