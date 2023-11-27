function [res,PP] = inhour(lambda, L, beta, rho)
    PP = zeros(8, 6);
    for i=1:6   
        PP(:,i) = [zeros(6,1); 1; lambda(i)];
    end

    PP_aux = [zeros(6,1); -L; rho-sum(beta)];
    PPres1 = [zeros(7,1); 1];

    for i=1:6   
        PPres1 = conv(PP(:,i), PPres1);
    end
   
    PPres1 = conv(PP_aux, PPres1);
    PPres1 = PPres1(end-7:end);
    
    PN = [ zeros(7,6);ones(1, 6)];
    for k = 1:6
        for i=1:6
            if i==k
            else 
                aaa = conv(PN(:,k), [zeros(6,1); 1; lambda(i)]);
                PN(:,k) = aaa(end-7:end);
            end
        end
        PN(:,k) = PN(:,k)*beta(k)*lambda(k);
    end

    PPres2 = sum(PN,2);
    PPres2 = PPres2(end-7:end);

    PP = PPres1+PPres2;
    ss = [-200.7647; -3.72268; -1.14757; -0.16620; 0.12353; -0.49175; -0.13513];
    p = PP 
    s = roots(poly(ss))

    a = PP-poly(ss)'

    res = roots(PP)
    %{
    PP = @(x) polyval(PP, x);
    ss = [-200.7647; -3.72268; -1.14757; -0.16620; 0.12353; -0.49175; -0.13513];
    options = optimset('fzero');

    for i=1:7
        res(i) = fzero(PP, ss(i), options);
    end
    %}



