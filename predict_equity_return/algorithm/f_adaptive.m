function [predY, predY_test, M] = f_adaptive(Xtrain, ytrain, Xtest, keep_svd1, keep_svd2)
    [Ux, Sx, Vx] = svds(Xtrain', keep_svd1);
    Z = Ux;
    ZtY = Z'*ytrain';
    [Uzy, Szy, Vzy] = svds(ZtY, keep_svd2);
    M = Vx * diag(1./diag(Sx)) * Uzy * Szy * Vzy';                            
    predY = Xtrain'*M;
    predY = predY';
    predY_test = Xtest'*M;
    predY_test = predY_test';
 
end

