close all; clc; clear;
%In questo codice MATLAB verrà costruito l'algoritmo CORE come descritto
%all'interno del paper: "CORE: A numerical algorithm to solve the point
%kinetics equation" di QUintero Leyva.

%questo file contiene i dati iniziali del problema e richiama il solutore

%Dati sul passo del problema e numero intervalli
h = Constants.h;
t_0 = 0;
t_max = 1;

n = floor((t_max - t_0)/h);

%Dati reattore
beta = Constants.beta;
BETA = sum(beta);
lambda = Constants.lambda;
LAMBDA = Constants.LAMBDA;

%Condizioni iniziali del problema (situazione critica), come elencate nel
%paper
N_0 = 1; 
C_0 = beta./(lambda*LAMBDA)*N_0;
C_dot_0 = zeros(1, 6);

y0 = [N_0, C_0, C_dot_0];

%Reattività in funzione del tempo
dollar = 0.003;
rho = dollar*ones(1, n);

[t,N, C, C_dot,S_k, PP] = CORE_solver(y0, rho, t_0, t_max, h);

ss = [-200.7647; -3.72268; -1.14757; -0.16620; 0.12353; -0.49175; -0.13513];

polyval(PP, ss)
polyval(PP, S_k)
ss-S_k

plot(t, N, "r");

figure()
hold on
plot(t, C(:,1), "r");
plot(t, C_dot(:,1), "g");
%{
plot(linspace(t_0, t_max, n), C(:,3), "b");
plot(linspace(t_0, t_max, n), C(:,4), "k");
plot(linspace(t_0, t_max, n), C(:,5), "y");
plot(linspace(t_0, t_max, n), C(:,6), "p");
%}

