function [theta]= thetaFromNormal(X, y, alpha)
    feat = @(A) cat(2, ones(size(A, 1), 1), A);
    matrsol = @(A, c) pinv(A'*A)*A' + c*eye(size(A, 1));
    if (size(feat(X), 1) == size(y, 1)) && (size(y, 2) == 1)
        theta = matrsol(feat(X), alpha)*y;
    else
        display('Check input sizes. Recall that y should be a column vector.');
        display(num2str(size(feat(X)')),'Size of X-transposed:');
        display(num2str(size(y)),'Size of y:');
        theta = inf(size(feat(X)'));
    end
return
