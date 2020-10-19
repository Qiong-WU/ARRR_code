lambda =  1:1:10;
n = size(x_train,2);
scale_lambda = n * lambda * 1e8;

corrMatrix = zeros(1,length(scale_lambda));
mseMatrix = zeros(1,length(scale_lambda));
corrMatrixOut = zeros(1,length(scale_lambda));
mseMatrixOut = zeros(1,length(scale_lambda));
corrMatrixVal = zeros(1,length(scale_lambda));
mseMatrixVal = zeros(1,length(scale_lambda));

for i= 1:size(scale_lambda,2)
    M = (x_train*x_train' + scale_lambda(i)*eye(size(x_train*x_train'))) \ x_train * y_train';
    predY = x_train'*M;
    predY = predY';
    predY_test = x_test'*M;
    predY_test = predY_test';
    predY_val = x_val'*M;
    predY_val = predY_val';
    corrMatrixVal(i) = corr(predY_val(:),y_val(:));
    mseMatrixVal(i) = mean((predY_val(:) - y_val(:)).^2);
    corrMatrix(i) = corr(predY(:),y_train(:));
    corrMatrixOut(i) = corr(predY_test(:),y_test(:));
    mseMatrix(i)= mean((predY(:) - y_train(:)).^2);
    mseMatrixOut(i) = mean((predY_test(:) - y_test(:)).^2);
end

[~, min_index]=  min(mseMatrixVal(:));
ridge_lambda = scale_lambda(min_index);


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





