function [predY, predY_test, M]  = f_lasso(Xtrain, Ytrain, Xtest,lambda)
    d1 = size(Xtrain,2);
    d2 = size(Ytrain,2);
    M = zeros(d1,d2);
    for i = 1:d2
        b_lasso = lasso(Xtrain,Ytrain(:,i),'Lambda', lambda);
        M(:,i) = b_lasso';
    end
    M(isnan(M)) = 0;
    predY = Xtrain * M;
    predY = predY';
    predY_test = Xtest * M;
    predY_test = predY_test';
end


