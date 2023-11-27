function Init(n)
    %Questo script permette di simulare l'equazione PKE modificandone i
    %parametri iniziali, attraverso una espansione in serie di Taylor del
    %sistema di EDO, come descritto da: "A Taylor series solution of the 
    %reactor point kinetics equations" di McMahon e Pierson. 
    
  
    
    %Passo dell'algoritmo
    h = 0.0001;
    
    t0 = 0;
    t_max = 40;

    %Parametri propri del reattore considerato
    [lambda, beta, LAMBDA, rho_0, alpha, q] = cases(n);
    sum(beta)
    %Reattività per ogni istante temporale
    n = floor((t_max - t0)/h);
    
    %Valori iniziali per risolvere il problema di Cauchy associato al sistema
    %di EDO. 
    N0 = 1;
    C0 = beta./(LAMBDA*lambda);
    y0 = [N0; C0];
    
    [t, N, C] = taylorPkeSolver(LAMBDA, lambda, beta, y0, rho_0, t0,t_max, h);
    
    figure()
    plot(t,N,"r")
end
