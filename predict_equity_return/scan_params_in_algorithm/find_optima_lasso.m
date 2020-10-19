function lasso_lambda = find_optima_lasso(Xtrain, ytrain, Xtest, ytest)  
    raw_lambda = [1e-10 1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1];
    [~,n] = size(Xtrain);
    lambda = n*raw_lambda;
    errorMatrix = [];
    for i= 1:size(lambda,2)
        [~, predY_test,~] = f_lasso(Xtrain', ytrain', Xtest',lambda(i));
        errorMatrix(i) = norm(ytest(:) - predY_test(:));   
    end
    [~, l_index]= min(errorMatrix(:));
    lasso_lambda = lambda(l_index);
    
end
