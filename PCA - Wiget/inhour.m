function [res,PP] = inhour(lambda, L, beta, rho)
   
    for i=1:6   
        PP(:,i) = [1; lambda(i)];
    end
    PP_aux = [L; -rho+sum(beta)];
    PPres1 = [1];

    for i=1:6   
        PPres1 = conv(PP(:,i), PPres1);
    end

    PPres1 = conv(PP_aux, PPres1);

    PN = zeros(6, 6);
    for k = 1:6
        aaa = 1;
        for i=1:6
            if i~=k
                aaa = conv(aaa, [1; lambda(i)]);
            end
        end
        aaa = aaa*beta(k)*lambda(k);
        PN(:,k) = aaa;
    end

    PPres2 = [0; 0; sum(PN,2)];
    

    PP = PPres1-PPres2;

    %ss = [-200.7647; -3.72268; -1.14757; -0.16620; 0.12353; -0.49175; -0.13513];

    res = roots(PP);
    %{
    PP = @(x) polyval(PP, x);
    ss = [-200.7647; -3.72268; -1.14757; -0.16620; 0.12353; -0.49175; -0.13513];
    options = optimset('fzero');

    for i=1:7
        res(i) = fzero(PP, ss(i), options);
    end
    %}



