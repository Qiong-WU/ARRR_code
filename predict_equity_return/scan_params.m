%scan parameters for each method
addpath(genpath('./nnls'))
if mode == 2
    [keep_svd1, keep_svd2] = find_optima_adaptive(Xtrain,ytrain,Xval,yval);
elseif mode == 3
    nuclear_lambda = find_optima_nuclear(Xtrain,ytrain,Xval,yval);
elseif mode == 4
    rrr_rank = find_optima_rrr(Xtrain,ytrain,Xval,yval);
elseif mode == 6
    ridge_lambda = find_optima_ridge(Xtrain,ytrain,Xval,yval);
elseif mode == 7
    [opt_rnk, opt_lambda]= find_optima_low_ridge(Xtrain,ytrain,Xval,yval);
elseif mode == 8
    lasso_lambda = find_optima_lasso(Xtrain,ytrain,Xval,yval);
end

