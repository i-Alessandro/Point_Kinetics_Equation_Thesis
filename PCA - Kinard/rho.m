function y = rho(case_number, beta_sum , t)
% This function represents the time-dependent reactivity function
%  for the point kinetics equation. We will use the argument "case"
%  to determine what type of reactivity we have in question. If an
% unknown case is encountered the function returns 0.
% case_number = 1 Step reactivity of rho = 0.003
% case_number = 2 Step reactivity of rho = 0.0055
% case_number = 3 Ramp reactivity

if case_number == 1
result = .003;
end
if case_number == 2
result = .0055;
end
if case_number == 3
result = 0.1*beta_sum*t;
end
y=result; 