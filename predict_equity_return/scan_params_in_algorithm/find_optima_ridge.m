function ridge_lambda = find_optima_ridge(Xtrain, ytrain, Xtest, ytest)
    [~,n] = size(Xtrain);
    raw_lambda = 1e-4:1e-3:1e-1;
    lambda = n*raw_lambda;
    errorMatrix = [];
    for i= 1:size(lambda,2)
        [~, predY_test,~] = f_ridge(Xtrain, ytrain, Xtest, lambda(i));
        errorMatrix(i) = norm(predY_test(:) - ytest(:));
    end
    [~, r_index]= min(errorMatrix(:));
    ridge_lambda = lambda(r_index);
end