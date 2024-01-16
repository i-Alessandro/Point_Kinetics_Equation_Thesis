function y = myRichardson_Benchmark(F, t, q, u_0, h, n, toll)
    
    R(:, 1, 1) = F(u_0, h);
    for i=1:100
       h = h/2;
    
       R(:, i + 1, 1) = F(u_0,h);
    
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