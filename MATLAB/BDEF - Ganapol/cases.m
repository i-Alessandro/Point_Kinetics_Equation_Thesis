
function [lambda, beta, L, rho_0, alpha, q,tmax] = cases(n)

    if(n==0)
        %Benchmark
        lambda = [1.26e-3; 3.17e-2; 1.15e-1; 3.11e-1; 1.4; 3.87];
        beta = [266e-6; 1491e-6; 1316e-6; 2849e-6; 896e-6; 182e-6];
        L = 5e-5;
        
        rho_init = 0.1;
        rho_0 = @(t) rho_init*t;
        
        alpha = -1e-11;
        q = zeros(8,1);
        tmax = 0.25;
    
    elseif(n==1)
        %Step Insertion of rho = 0.003
        beta = [0.000266, 0.001491, 0.001316, 0.002849, 0.000896, 0.000182]';
        lambda = [0.0127, 0.0317, 0.115, 0.311, 1.4, 3.87]'; 
        L = 2e-5;
        
        rho_init = 0.003;
        rho_0 = @(t) rho_init;
        
        alpha = 0;
        q = zeros(8,1);
        tmax=20;

    elseif(n==2)
        %Step Insertion of rho = 0.007
        beta = [0.000266, 0.001491, 0.001316, 0.002849, 0.000896, 0.000182]';
        lambda = [0.0127, 0.0317, 0.115, 0.311, 1.4, 3.87]'; 
        L = 2e-5;
        
        rho_init = 0.007;
        rho_0 = @(t) rho_init;
        
        alpha = 0;
        q = zeros(8,1);
        tmax=2;

    elseif(n==3)
        %Step Insertion of rho = 0.008
        beta = [0.000266, 0.001491, 0.001316, 0.002849, 0.000896, 0.000182]';
        lambda = [0.0127, 0.0317, 0.115, 0.311, 1.4, 3.87]'; 
        L = 2e-5;
        
        rho_init = 0.008;
        rho_0 = @(t) rho_init;
        
        alpha = 0;
        q = zeros(8,1);
        tmax=1;
    
    
    elseif(n==4)
        %Ramp Insertion of 0.1$
        beta = [0.000266, 0.001491, 0.001316, 0.002849, 0.000896, 0.000182]';
        lambda = [0.0127, 0.0317, 0.115, 0.311, 1.4, 3.87]'; 
        L = 2e-5;
        
        rho_init = 0.007*0.1;
        rho_0 = @(t) rho_init*t;
        
        alpha = 0;
        q = zeros(8,1);
        tmax=9;
    
    elseif(n==5)
        %Sinusoidal Insertion T=50, rho_0 = 0.0053333
        beta = 0.0079;
        lambda = 0.077;
        L = 1e-8;
        
        rho_init = 0.0053333;
        T=50;
        rho_0 = @(t) rho_init*sin(pi*t/T);
        
        alpha = 0;
        q = zeros(3,1);
        tmax=100;
    
    
    elseif(n==6)
        %Step Insertion of rho = 0.007 with feedback
        lambda = [1.24e-2; 3.05e-2; 1.11e-1; 3.01e-1; 1.13; 3];
        beta = [2.1e-4; 1.41e-3; 1.27e-3; 2.55e-3; 7.4e-4; 2.7e-4];
        L = 5e-5;
        
        rho_init = sum(beta)*1.5;
        rho_0 = @(t) rho_init;
        
        alpha = -2.5e-6;
        q = zeros(8,1);
        tmax=100;
    
    
   elseif(n==7)
        %Ramp Insertion of 0.1$ with feedback
        lambda = [1.24e-3; 3.05e-2; 1.11e-1; 3.01e-1; 1.13; 3];
        beta = [2.1e-4; 1.41e-3; 1.27e-3; 2.55e-3; 7.4e-4; 2.7e-4];
        L = 5e-5;
        
        ramp_rate = 0.1;
        rho_0 = @(t) ramp_rate*t;
        
        alpha = -1e-11;
        q = zeros(8,1);
        tmax=10;
    
    end
end

    
    
    