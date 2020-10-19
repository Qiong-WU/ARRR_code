function [predY, predY_test, M] = f_ridge(Xtrain, Ytrain, Xtest, lambda)
    [n, ~] = size(Xtrain);
    scale_lambda = n * lambda;
    M = (Xtrain*Xtrain' + scale_lambda*eye(size(Xtrain*Xtrain'))) \ Xtrain * Ytrain';
    predY = Xtrain'*M;
    predY = predY';
    predY_test = Xtest'*M;
    predY_test = predY_test';
end
