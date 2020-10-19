function nuclear_lambda = find_optima_nuclear(Xtrain, ytrain, Xtest, ytest)
    [~,n] = size(Xtrain);
    warning('off')
    raw_lambda = [1e-12 1e-11 1e-10 1e-9 1e-8 1e-7 1e-5 1e-4 1e-3 1e-2 1e-1 1 10];
    lambda = n*raw_lambda;
    errorMatrix = [];

    for i = 1:length(lambda)
        nextlambda = lambda(i);
        beta = f_nuclear_mlr(ytrain', Xtrain', nextlambda);
        estYtt = Xtest' * beta;
        err = norm(ytest(:) - estYtt(:));  
        errorMatrix(i) = err;

    end

    min_il = find(errorMatrix == min(errorMatrix));
    nuclear_lambda = lambda(min_il(1));

end