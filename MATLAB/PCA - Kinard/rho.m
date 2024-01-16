function y = rho(case_number, beta_sum , t)
% This function represents the time-dependent reactivity function
%  for the point kinetics equation. We will use the argument "case"
%  to determine what type of reactivity we have in question. If an
% unknown case is encountered the function returns 0.

if case_number == 1
result = .003;
end
if case_number == 2
result = .007; %0.0055
end

if case_number == 3
result = 0.008;
end

if case_number == 4
result = 0.1*beta_sum*t;
end

if case_number == 5
result = 0.005333*sin(pi*t/50);
end

y=result; 