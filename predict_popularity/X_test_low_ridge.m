max_v = min([50,size(y_test,1),size(y_test,2)]);
keep_svd = 1:1:max_v;
lambda = 1:0.5:10;
n = size(x_train,2);
scale_lambda = n * lambda * 1e8;

corrMatrix = zeros(length(keep_svd), length(lambda));
mseMatrix = zeros(length(keep_svd), length(lambda));
corrMatrixOut = zeros(length(keep_svd), length(lambda));
mseMatrixOut = zeros(length(keep_svd), length(lambda));
corrMatrixval = zeros(length(keep_svd), length(lambda));
mseMatrixval = zeros(length(keep_svd), length(lambda));

for i = 1:length(keep_svd)
    for j = 1:length(scale_lambda)
        [~, ~, V] = svd(y_train');
        P = V(:, 1:keep_svd(i)) * V(:, 1:keep_svd(i))';
        M = (x_train*x_train' + scale_lambda(j)*eye(size(x_train*x_train'))) \ x_train * y_train' * P;

        predY = x_train'*M;
        predY = predY';
        predY_test = x_test'*M;
        predY_test = predY_test'; 
        predY_val = x_val'*M;
        predY_val = predY_val';        
        corrMatrix(i,j) = corr(predY(:),y_train(:));
        mseMatrix(i,j) = mean((predY(:) - y_train(:)).^2);
        corrMatrixOut(i,j) = corr(predY_test(:),y_test(:));
        mseMatrixOut(i,j) = mean((predY_test(:) - y_test(:)).^2);        
        corrMatrixval(i,j) = corr(predY_val(:),y_val(:));
        mseMatrixval(i,j) = mean((predY_val(:) - y_val(:)).^2);
    end
end


[min_re, min_ie] =  find(mseMatrixval == min(mseMatrixval(:)));
opt_rnk = keep_svd(min_re(1));
opt_lambda = lambda(min_ie(1));

disp('corr');
disp(corrMatrix(min_re,min_ie));
disp(corrMatrixOut(min_re,min_ie));

disp('Mse');
disp(mseMatrix(min_re,min_ie));
disp(mseMatrixOut(min_re,min_ie));

bestCorr = corrMatrix(min_re,min_ie);
bestCorrOut = corrMatrixOut(min_re,min_ie);

bestMse = mseMatrix(min_re,min_ie);
bestMseOut  = mseMatrixOut(min_re,min_ie);
