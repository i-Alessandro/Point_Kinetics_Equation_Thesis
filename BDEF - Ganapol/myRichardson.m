function y = myRichardson(invA, q, u_0, delta, n, toll)
    
    PHI = [zeros(length(u_0), n+1)];
    
    for i = 1:n+1
        h = delta/2^(i-1);
%{
        F = @(y) -(eye(length(u_0)) - h*A)*y + u_0 + h*q;
        options = optimoptions('fsolve','TolFun', toll);
        PHI(:, i) = fsolve(F, u_0, options);
%}
        PHI(:,i) = invA(h)*(u_0+h*q);
    end

    for i = 1:n
        prec = PHI(:,1);
        for j=1:(n+1-i)
            PHI(:,j) = (2^(i)*PHI(:,j+1) - PHI(:,j))/(2^(i)-1);
        end
        PHI(:, (n+2-i)) = zeros(length(u_0),1);
        if norm(prec - PHI(:,1)) < toll
            y = PHI(:,1);
            return
        end
    end
    y = PHI(:,1);