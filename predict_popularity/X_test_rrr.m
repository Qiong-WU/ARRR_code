n = size(x_train,2);
d1 = size(x_train,1);
rgbeta = 1:2:n;

corrMatrix = zeros(1,length(rgbeta));
mseMatrix = zeros(1,length(rgbeta));
corrMatrixOut = zeros(1,length(rgbeta));
mseMatrixOut = zeros(1,length(rgbeta));
corrMatrixVal = zeros(1,length(rgbeta));
mseMatrixVal = zeros(1,length(rgbeta));


for j = 1:length(rgbeta)
        keep_svd = min(n,d1);
        keep_beta = rgbeta(j);
        [ux, sx, vx] = svds(x_train',keep_svd);
        Beta = ux' * y_train';
        [ub, sb, vb] = svds(Beta,keep_beta);
        lowBeta = ub * sb * vb';
        estAp = vx * sx^(-1) * lowBeta;
        predY = x_train' * estAp;
        predY = predY';
        predY_test = x_test' * estAp;
        predY_test = predY_test';
        
        predY_val = x_val'*estAp;
        predY_val = predY_val';
        corrMatrixVal(j) = corr(predY_val(:),y_val(:));
        mseMatrixVal(j) = mean((predY_val(:) - y_val(:)).^2);
        
        corrMatrix(j) = corr(predY(:),y_train(:));
        corrMatrixOut(j) = corr(predY_test(:),y_test(:));
        mseMatrix(j)= mean((predY(:) - y_train(:)).^2);
        mseMatrixOut(j) = mean((predY_test(:) - y_test(:)).^2);
        
        
end

[~, min_index]=  min(mseMatrixVal(:));
rrr_beta = rgbeta(min_index);

disp('RRR')
disp(rrr_beta)

disp('corr');
disp(corrMatrix(min_index));
disp(corrMatrixOut(min_index));

disp('Mse');
disp(mseMatrix(min_index));
disp(mseMatrixOut(min_index));

bestCorr = corrMatrix(min_index);
bestCorrOut = corrMatrixOut(min_index);

bestMse = mseMatrix(min_index);
bestMseOut  = mseMatrixOut(min_index);

