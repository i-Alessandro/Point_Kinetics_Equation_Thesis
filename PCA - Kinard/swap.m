function y = swap(arg)
% This simple function takes the 1st element of arg and puts it in the
% mth place of the resultant vector, and puts the 2nd in the m-lst, ,and
% so on. . .
m = length(arg);
res = zeros(1,m);
for i = 1:m
    res(m-i+1) =arg(i);
end

y = res;
