function  rrr_rank = find_optima_rrr(Xtrain, ytrain, Xtest, ytest)
    rgbeta = 1:1:50;
    errorMatrix = zeros(1,length(rgbeta));
    for j = 1:length(rgbeta)
            keep_beta = rgbeta(j);
            [~, predY_test, ~] = f_rrr(Xtrain, ytrain, Xtest, keep_beta);
            err = norm(ytest(:)- predY_test(:));
            errorMatrix(j) = err;
    end
    min_ie = find(errorMatrix == min(errorMatrix(:)));
    rrr_rank = rgbeta(min_ie(1));
end