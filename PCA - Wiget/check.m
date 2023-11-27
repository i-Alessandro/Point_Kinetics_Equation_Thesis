function y = check(lambda, beta, L, rho, omega)

    P1 = 1;

    for i=1:6
        P1 = P1*(lambda(i)+omega);
    end



    y = (rho-ones(1,6)*beta-L*omega)*P1 + (beta./(omega+lambda))'*lambda;

end