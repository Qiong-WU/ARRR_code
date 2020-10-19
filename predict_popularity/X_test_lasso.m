n = size(x_train,2);
raw_lambda = 1:0.5:20;
scale_lambda = n*raw_lambda; 

corrMatrix = zeros(1,length(scale_lambda));
mseMatrix = zeros(1,length(scale_lambda));
corrMatrixOut = zeros(1,length(scale_lambda));
mseMatrixOut = zeros(1,length(scale_lambda));
corrMatrixVal = zeros(1,length(scale_lambda));
mseMatrixVal = zeros(1,length(scale_lambda));
x_train = x_train';
y_train = y_train';
y_test = y_test';
x_test = x_test';


for i= 1:size(scale_lambda,2)
    d1 = size(x_train,2);
    d2 = size(y_train,2);
    M = zeros(d1,d2);
    for  j = 1:d2
        b_lasso = lasso(x_train,y_train(:,j),'Lambda', scale_lambda(i));
        M(:,j) = b_lasso';
    end
    predY = x_train * M;
    predY_test = x_test * M;  
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








