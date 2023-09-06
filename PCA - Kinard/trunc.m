function y = trunc(var, t)
% This is a simple helper method that removes the ith element
% from the vector var.
m = length(var); flag = 0;
temp = zeros(1,m-1);
for i = 1:m
if i ~= t && flag == 0
temp(i) = var(i);
end
if i ~= t && flag == 1
temp(i-1) = var(i);
end
if i == t
flag = 1;
end
end
y = transpose(temp);