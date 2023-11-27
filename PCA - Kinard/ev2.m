function y = ev2(lambda,L, beta, evals) 

% This is a simple function that calculates the eigenvectors using the
% appropriate forms.

m = length(lambda) + 1;
evects = zeros(m,m);
for i = 1:m
    for j = 1:m
        if i == 1
            evects(i,j) = 1;
        end
        if i~= 1
            mu = beta(i-1)/L;
            evects(i,j) = mu / (lambda(i-1) + evals(j));
        end
    end
end
y = evects;
