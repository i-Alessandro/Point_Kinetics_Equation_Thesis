% Point reactor kinetics 6 groups of delayed neutrons
beta = [0.000266; 0.001491; 0.001316; 0.002849; 0.000896; 0.000182];
betasum = sum(beta);
rho = 0.003; % reactivity
% Initial consitions
L = 0.00002;
lambda = [0.0127; 0.0317; 0.155; 0.311; 1.4; 3.87];
c0 = beta./(L*lambda);
n0 =  1;
tspan = [0, 20];
nc0 = [n0; c0];
[t, nc] = ode45(@(t,nc) kinetics(t,nc,rho,beta,betasum), tspan, nc0);
n = nc(:,1);
c = nc(:, 2:7);
plot(t,n),grid,
xlabel('time'), ylabel('n')


%{
% Define the differential equations
%lambda = [0.0127; 0.0317; 0.155; 0.311; 1.14; 3.87];
lambda = [0.0126; 0.0337; 0.111; 0.301; 1.14; 3.01];
%beta = [0.000266; 0.001491; 0.001316; 0.002849; 0.000896; 0.000182];
beta = [0.00021; 0.00141; 0.00127; 0.00255; 0.00074; 0.00027];
BETA = sum(beta);
LAMBDA = 0.0001;
rho = 0.01;

f = @(t,y) [(rho - BETA)*y(1)/LAMBDA + (lambda)'*y(2:7);
            beta*y(1)/LAMBDA - lambda.*y(2:7)];

% Define the initial conditions
y0 = [0.1; zeros(6,1)];

% Define the time span
tspan = [0 1];

% Solve the system
[t,y] = ode45(f, tspan, y0);

% Plot the solution
plot(t, y(:,1));
%plot(t, y(:,1), t, y(:,2), t, y(:,3), t, y(:,4), t, y(:,5), t, y(:,6), t, y(:,7));
legend('N', 'C 1', 'C 2', 'C 3', 'C 4', 'C 5', 'C 6');
xlabel('Time');
ylabel('Solution');
%}