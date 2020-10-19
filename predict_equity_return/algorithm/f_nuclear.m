function [predY, predY_test, M] = f_nuclear(Xtrain, ytrain, Xtest, nuclear_lambda)
    M = f_nuclear_mlr(ytrain', Xtrain', nuclear_lambda);
    predY = Xtrain'*M;
    predY = predY';
    predY_test = Xtest'*M;
    predY_test = predY_test';
end
