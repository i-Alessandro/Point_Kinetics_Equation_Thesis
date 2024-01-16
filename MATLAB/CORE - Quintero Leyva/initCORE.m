function [t, N, color]=initCORE(n,h)
%In questo codice MATLAB verra costruito l'algoritmo CORE come descritto
%all'interno del paper: "CORE: A numerical algorithm to solve the point
%kinetics equation" di Quintero Leyva.
%questo file contiene i dati iniziali del problema e richiama il solutore
%per l'equazione inhour e il file cases con i vari test
addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\PCA - Kinard')
addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\BDEF - Ganapol')

%Dati del problema e dati reattore
t_0 = 0;
[lambda, beta, LAMBDA, rho, alpha, q,t_max] = cases(n);

%Condizioni iniziali del problema (situazione critica), come elencate nel
%paper
N_0 = 1; 
C_0 = (beta./(lambda*LAMBDA)*N_0)';
C_dot_0 = zeros(1, 6);

y0 = [N_0, C_0, C_dot_0];

[t,N, C, C_dot,S_k] = CORE_solver(y0, rho, t_0, t_max, h, beta,lambda,LAMBDA,alpha);

color = [0.9290 0.6940 0.1250];

end
