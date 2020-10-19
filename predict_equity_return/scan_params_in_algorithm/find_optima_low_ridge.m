function [opt_rnk, opt_lambda] = find_optima_low_ridge(Xtrain, ytrain, Xtest,ytest)
    %scan the rnk first
    [~,n] = size(Xtrain);
    rnk= 50;
    raw_lambda = 1e-4:1e-3:1e-1;
    lambda = n*raw_lambda;
    rgsvdr = 1:rnk;
    errorMatrix = zeros(length(rgsvdr), length(lambda));
    for r = rgsvdr
        for i = 1:length(lambda)
            nextlambda = lambda(i);
            [~, predY_test,~] = f_low_ridge(Xtrain, ytrain, Xtest, nextlambda, r);
            errorMatrix(r, i) = norm(ytest(:) - predY_test(:)); 
        end
    end
    [min_re, min_ie] = find(errorMatrix == min(errorMatrix(:)));
    opt_rnk = rgsvdr(min_re(1));
    opt_lambda = lambda(min_ie(1));
end


