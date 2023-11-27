%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% European Call - BS model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [P_i] = FFT_BS(K_i) - could be a vector
% INPUT: K_i = strikes - could be a vector
% OUTPUT: P_i = prices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- model parameters
S = 100; % spot price
T = 1; % maturity
r = 0.0367; % risk-free interest rate
sig = 0.17801; % volatility
Npow = 15;
N = 2^(Npow); % grid point
A = 600; % upper bound
eta = A/N;
lambda = 2*pi/(N*eta);
k = -lambda * N/2 + lambda *(0:N-1); % log-strike grid
K = S * exp(k); % strike
v = eta*(0:N-1);
v(1)=1e-22; %correction term: could not be equal to zero
% (otherwise NaN)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PRICING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fourier transform of z_k
tr_fou = trasf_fourier_BS(r,sig,T,v);
% Trapezoidal rule
w = [0.5 ones(1,N-2) 0.5];
h = exp(1i*(0:N-1)*pi).*tr_fou.*w*eta;
P = S * real( fft(h)/pi + max(1-exp(k-r*T),0)); % prices

% delete too small and too big strikes
index=find( (K>0.1*S & K<3*S) );
K=K(index); P=P(index);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(K,P, 'r') ;
hold on
axis([0 2*S 0 S]) ;
xlabel('strike') ;
ylabel('option price') ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INTERPOLATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_i = interp1(K,P,K_i,'spline');