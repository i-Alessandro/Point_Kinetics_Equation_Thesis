function x = ptoFisso(phi, toll, x0, nmax,h)
    u_old = x0;
    u_new = phi(x0,h);
    j = 0;

    while norm(u_new-u_old)>toll && nmax>j 
     
        u_old = u_new; 
        u_new = phi(u_old,h);
        j = j+1;
    end
    
    x = u_new;
end