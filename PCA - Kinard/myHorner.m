function y=myHorner(a,z,n)
% Applies a functional implementation of the Horner mehtod
% The user supplies a(The poly), z(The root), and n(The degree)
% This program uses Horner's method to write p(x) = (x-z)q(x)+c
% Where p and q are polynomials of degree n and n-1 respectivly 

for i = 1:n+1
b(i) = 0.0;
end
b(n) = a(n+1);
if n>0
for i = 1:n
b(n+1-i) = a(n-i+2) + b(n+2-i)*z;
end
c= a(1) + b(1)*z;
end
for i = 1:n
a(i) = b(i);
end
for i =1:n
ret(i) = a(i);
end
ret(n) = ret(n) + c; %add the constant
y=ret; 
