function fi = rec(s, h, phi, toll, x0, nmax)
    if s == 0      
        fi = ptoFisso(phi, toll, x0, nmax,h);
        return 
    end
    
    f_prec = rec(s-1, h, phi, toll, x0, nmax);
    f_prec_mezzi = rec(s-1, h/2, phi, toll, x0, nmax);

    fi = (2^s*f_prec_mezzi - f_prec)/(2^s-1);
end