function [theta, costhist] = batchGradientDescent(X, y, theta, alpha, num_iters)

costhist = zeros(num_iters, 1);

costFun = @(A, b, c) sum((A * b - c) .^ 2) / (2 * length(c));

gradient = @(A, b, c) ((A * b - c)' * A)' / length(c);


for iter = 1:num_iters
    theta = theta - alpha * gradient;  %simultaneuously update all values in the weight vector

    costhist(iter) = costFun(X, y, theta);

end

return