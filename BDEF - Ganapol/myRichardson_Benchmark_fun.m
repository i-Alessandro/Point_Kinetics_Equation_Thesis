function y = myRichardson_Benchmark_fun(A, t, q, u_0, h, n, toll)
        %{
    PHI = [zeros(length(u_0), n+1)];
    
    for i = 1:n+1
        h = delta/2^(n+1-i);
        
        F = @(y) -(eye(length(u_0)) - h*A(y(1),t+h))*y + u_0 + h*q;
        options = optimoptions('fsolve','TolFun', toll, 'Display','off');
        PHI(:, i) = fsolve(F, u_0, options);

    end

    for i = 1:n
        temp = PHI;

        for j = i+1:n+1
            PHI(:,j) = (4^(i)*temp(:,j-1)-temp(:,j))/(4^(i)-1);
        end
        PHI(:,i) = zeros(length(u_0),1);
    end

    y = PHI(:,end);


    for i = 1:n
        prec = PHI(:,1);
        for j=1:(n+1-i)
            PHI(:,j) = (2^(i)*PHI(:,j+1) - PHI(:,j))/(2^(i)-1);
        end
        PHI(:, (n+2-i)) = zeros(length(u_0),1);
        %{
        if norm(prec - PHI(:,1)) < toll
            y = PHI(:,1);
            return
        end
        %}
    end
    y = PHI(:,1);
    %}

    F = @(y) -(eye(length(u_0)) - h*A(y(1),t+h))*y + u_0 + h*q;
    options = optimoptions('fsolve','TolFun', toll, 'Display','off');

    R(:, 1, 1) = fsolve(F, u_0, options);

    for i=1:100
       h = h/2;

       F = @(y) -(eye(length(u_0)) - h*A(y(1),t+h))*y + u_0 + h*q;
       options = optimoptions('fsolve','TolFun', toll, 'Display','off');
    
       R(:, i + 1, 1) = fsolve(F, u_0, options);
    
       for j=1:i
          R(:,i + 1, j + 1) = (2^j*R(:,i + 1, j) - R(:,i, j))/(2^j - 1);
       end
       
       if ( norm( R(:,i + 1, i + 1) - R(:,i, i) ) < toll )
          break;
       elseif ( i == 100 )
          error( 'Richardson extrapolation failed to converge' );
       end
       
    end
    y = R(:,i+1, i+1);
