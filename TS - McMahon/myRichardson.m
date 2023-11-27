function y = myRichardson(A, q, u_0, h, n, toll)
    %{
    F = @(y) -(eye(length(u_0)) - h*A)*y + u_0 + h*q;
    options = optimoptions('fsolve','TolFun', toll, 'Display','off');

    R(:, 1, 1) = fsolve(F, u_0, options);

    for i=1:100
       h = h/2;

       F = @(y) -(eye(length(u_0)) - h*A)*y + u_0 + h*q;
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
    %}

    R(:, 1, 1) = (1+h*A(h))*u_0;
    for i=1:100
       h = h/2;
    
       R(:, i + 1, 1) = (1+h*A(h))*u_0;
    
       for j=1:i
          R(:,i + 1, j + 1) = (2^j*R(:,i + 1, j) - R(:,i, j))/(2^j - 1);
       end
       
       if ( norm( R(:,i + 1, i + 1) - R(:,i, i) ) < toll )
          break;
       elseif ( i == 100 )
          error( 'Richardson extrapolation failed to converge' );
       end
       
    end
    y = R(:,i+1, i+1)