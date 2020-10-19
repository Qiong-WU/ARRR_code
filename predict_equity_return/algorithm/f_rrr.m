function [predY, predY_test, M] = f_rrr(Xtrain, ytrain, Xtest, rrr_rank)
    keep_svd = min(size(Xtrain,1),size(Xtrain,2));
    [ux, sx, vx] = svds(Xtrain',keep_svd);
    Beta = ux' * ytrain';
    [ub, sb, vb] = svds(Beta,rrr_rank);
    lowBeta = ub * sb * vb';
    M = vx * sx^(-1) * lowBeta;
    predY_test = Xtest' * M;
    predY_test = predY_test';
    predY = Xtrain' * M;
    predY = predY';        
end
