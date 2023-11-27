% figure
% plot(t,c),grid
% xlabel('time'), ylabel('c')
function dncdt = kinetics(~,nc,rho,beta,betasum)
        
        L = 0.00002;
        lam = [0.0127; 0.0317; 0.155; 0.311; 1.4; 3.87];
        n = nc(1);
        c = nc(2:7);
        dndt = (rho - betasum)/L*n+ sum(lam.*c);
        dcdt = beta*n/L - lam.*c;
        
        dncdt = [dndt; dcdt];        
end