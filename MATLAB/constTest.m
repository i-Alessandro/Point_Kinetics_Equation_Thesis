function elapsedTime = constTest()
    clc;clear all; %close all; 
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\BDEF - Ganapol')
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\CORE - Quintero Leyva')
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\PCA - Kinard')
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\TS - McMahon')

    %{
    n = 6;
    tic
    [T_pca,N_pca,color_pca] = initPCA(n);
    toc
    tt(1) = toc;
    tic
    [T_ts, N_ts, color_ts, N1_ts, color1_ts] = initTS(n);
    toc
    tt(2) = toc;
    tic
    [T_core, N_core, color_core]=initCORE(n);
    toc
    tt(3) = toc;
    tic
    [T_befd, N_befd, color_befd] = initBEFD(n);
    toc
    tt(4) = toc;
   
    xlabel('Time') 
    ylabel('Neutron density')
    loglog(T_pca,N_pca, Color =color_pca)
    hold on
    loglog(T_befd,N_befd, Color = color_befd)
    loglog(T_ts,N_ts, Color = color_ts)
    loglog(T_ts,N1_ts, Color = color1_ts)
    loglog(T_core, N_core, Color = color_core)
    legend({'PCA', 'BEFD', 'TS', 'TS + Modifiche', 'CORE'}, 'Location','southeast','NumColumns',2)
    hold off

    %}
    n = 0;
    h = 1e-5;
    elapsedTime = [];
    tic
    [T_pca,N_pca,color_pca] = initPCA(n,h*500);
    toc
    elapsedTime(1) = toc;
    tic
    [T_ts, N_ts, color_ts, N1_ts, color1_ts] = initTS(n,h);
    toc
    elapsedTime(2) = toc;
    tic
    [T_core, N_core, color_core]=initCORE(n,h);
    toc
    elapsedTime(3) = toc;
    tic
    [T_befd, N_befd, color_befd] = initBEFD(n,h);
    toc
    elapsedTime(4) = toc;


    xlabel('Time') 
    ylabel('Neutron density')
    semilogy(T_pca,N_pca, Color =color_pca)
    hold on
    semilogy(T_befd,N_befd, Color = color_befd)
    semilogy(T_ts,N_ts, Color = color_ts)
    semilogy(T_ts,N1_ts, Color = color1_ts)
    semilogy(T_core, N_core, Color = color_core)
    legend({'PCA', 'BEFD', 'TS', 'TS + Modifiche', 'CORE'}, 'Location','southeast','NumColumns',2)
end