function [predY, predY_test, M]  = f_low_ridge(Xtrain, Ytrain, Xtest, lambda, keep_svd)
    [~, ~, V] = svd(Ytrain');
    P = V(:, 1:keep_svd) * V(:, 1:keep_svd)';
    M = (Xtrain*Xtrain' + lambda*eye(size(Xtrain*Xtrain'))) \ Xtrain * Ytrain' * P;
    predY = Xtrain'*M;
    predY = predY';
    predY_test = Xtest'*M;
    predY_test = predY_test';
end
