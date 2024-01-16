% pcrun.m
% This is a dummy script to run the piecewise constant function

% Chao and Attard
% lambda = [0.0127, 0.0317, 0.115, 0.311, 1.4, 3.87]; L = 0,00002;
% beta = [0.000266, 0.001491, 0.001316, 0.002849, 0.000896,
% 0.000182] ;
% beta_sum = 0.007;

% Norbrega Thermal Reactor
% lambda = [0.0127, 0.0317, 0.115, 0.311, 1.40, 3.87];
% L = 5e-4;
% beta = [2.850e-4, 1.5975e-3, 1.410e-3, 3.0525e-3, 9.600e-4, 1.950e-4];
% beta_sum = 0.00750;

% Norbreaga Fast Reactor
% lambda = [0.0129, 0.0311, 0.134, 0.331, 1.26, 3.21];
% L = le-7 ;
% beta = [1.672e-4 , 1.232e-3, 9.504e-4, 1.443e-3, 5.434e-4, 1.540e-4];
% beta.sum = 0.00440; 

% 'IX Two Group
% lambda = [0.077] ;
% L = [0.0001];
% beta = [.0079] ;
% beta_sum = 0.0079

%A short code for computing the initial equilibrium conditions 

m = length(lambda);
init_cond = zeros(m+l,1);
init_cond(l) = 1;
for i = l:m
    init_cond(i+l) = beta(i) / (L* lambda(i));
end
rval = transpose([0,0,0,0,0,0,0]);
z = piecewise_const(lambda, beta, beta_sum, L, 1, 0.1 , 1 , 1, init_cond, rval);
