function [t, N, color, N_1, color1]=initTS(n,h) 
    %Questo script permette di simulare l'equazione PKE modificandone i
    %parametri iniziali, attraverso una espansione in serie di Taylor del
    %sistema di EDO, come descritto da: "A Taylor series solution of the 
    %reactor point kinetics equations" di McMahon e Pierson. 
    
    addpath('C:/Users/alewi/Desktop/Tesi/MATLAB/PCA - Kinard')
    addpath('C:/Users/alewi/Desktop/Tesi/MATLAB/BDEF - Ganapol')

    t0 = 0;

    %Parametri propri del reattore considerato
    [lambda, beta, LAMBDA, rho_0, alpha, q, t_max] = cases(n);

    sum(beta)
    %Valori iniziali per risolvere il problema di Cauchy associato al sistema
    %di EDO. 
    N0 = 1;
    C0 = beta./(LAMBDA*lambda);
    y0 = [N0; C0];
    tic
    [t, N, C, N_1, C_1] = taylorPkeSolver(LAMBDA, lambda, beta, y0, rho_0, t0,t_max, h, alpha);
    toc
    color = 'r';
    color1 = 'g';

    plot(t,N_1,'r')
end
