function sinTest()
    clc;clear all; close all; 
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\BDEF - Ganapol')
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\CORE - Quintero Leyva')
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\PCA - Kinard')
    addpath('C:\Users\alewi\Desktop\Tesi\MATLAB\TS - McMahon')

    n = 5;
    tic
    [T_pca,N_pca,color_pca] = initPCA(n);
    toc
    %[T_ts, N_ts, color_ts, N1_ts, color1_ts] = initTS(n);
    tic
    [T_core,N_core,color_core] = initCORE(n);
    toc
    tic
    [T_befd, N_befd, color_befd] = initBEFD(n);
    toc


    xlabel('Time') 
    ylabel('Neutron density')
    plot(T_pca,N_pca, Color =color_pca)
    hold on
    %plot(T_ts,N_ts, Color = color_ts)
    %plot(T_ts,N1_ts, Color = color1_ts)
    plot(T_core,N_core, Color=color_core)
    plot(T_befd,N_befd, Color = color_befd)
    legend({'PCA','CORE', 'BEFD'}, 'Location','northwest','NumColumns',2)
end