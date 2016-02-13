function [X_norm, mu, sigma] = normalizeColumns(X)

%assumes one column of X is one feature

% allocate memory
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));
X_norm = X;

%repeats vector b as a row a number of times to match row number in A
columnwise = (@) (A, b) ones(size(A)) * diag(b);

%compute mean of each column and substract from original data
mu = mean(X, 1);
X_norm = X_norm - columnwise(mu);

%compute standard deviation of each column and divide by it
sigma = std(X_norm, 1);
X_norm = X_norm ./ columnwise(sigma);

end
