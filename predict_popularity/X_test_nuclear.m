
addpath(genpath('./nnls'))
raw_lambda = 1:0.5:10;
n = size(x_train,2);
lambda = n*raw_lambda*1e7;

corrMatrix = zeros(1,length(lambda));
mseMatrix = zeros(1,length(lambda));
corrMatrixOut = zeros(1,length(lambda));
mseMatrixOut = zeros(1,length(lambda));
corrMatrixVal = zeros(1,length(lambda));
mseMatrixVal = zeros(1,length(lambda));

for i = 1:length(lambda)
    nextlambda = lambda(i);
    beta = f_nuclear_mlr(y_train', x_train', nextlambda);
    M = beta;
    predY = x_train' * M;
    predY = predY';
    predY_test = x_test' * M;
    predY_test = predY_test';
    corrMatrix(i) = corr(predY(:),y_train(:));
    corrMatrixOut(i) = corr(predY_test(:),y_test(:));
    mseMatrix(i)= mean((predY(:) - y_train(:)).^2);
    mseMatrixOut(i) = mean((predY_test(:) - y_test(:)).^2);
    predY_val = x_val'* M;
    predY_val = predY_val';
    corrMatrixVal(i) = corr(predY_val(:),y_val(:));
    mseMatrixVal(i) = mean((predY_val(:) - y_val(:)).^2);
    
end

[~, r_index]=  min(mseMatrixVal(:));
nuclear_lambda = lambda(r_index);


disp('corr');
disp(corrMatrix(r_index));
disp(corrMatrixOut(r_index));

disp('Mse');
disp(mseMatrix(r_index));
disp(mseMatrixOut(r_index));


bestCorr = corrMatrix(r_index);
bestCorrOut = corrMatrixOut(r_index);

bestMse = mseMatrix(r_index);
bestMseOut  = mseMatrixOut(r_index);
