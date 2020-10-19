rg_svd_d1 = 1:1:50;
rg_svd_d2 = 1:1:30;
n_d1 = length(rg_svd_d1);
n_d2 = length(rg_svd_d2);

corrMatrix = zeros(length(n_d1), length(n_d2));
mseMatrix = zeros(length(n_d1), length(n_d2));
corrMatrixOut = zeros(length(n_d1), length(n_d2));
mseMatrixOut = zeros(length(n_d1), length(n_d2));
corrMatrixVal = zeros(length(n_d1), length(n_d2));
mseMatrixVal = zeros(length(n_d1), length(n_d2));

for i = 1:n_d1
    for j = 1:n_d2
        svd_d1 = rg_svd_d1(i);
        svd_d2 = rg_svd_d2(j);        
        [Ux, Sx, Vx] = svds(x_train', svd_d1);
        Z = Ux;
        ZtY = Z'*y_train';
        [Uzy, Szy, Vzy] = svds(ZtY, svd_d2);
        M1 = Vx * diag(1./diag(Sx)) * Uzy * Szy * Vzy';
        predY = x_train'*M1;
        predY = predY';
        predY_test = x_test'*M1;
        predY_test = predY_test';
        predY_val = x_val'*M1;
        predY_val = predY_val';     
        corrMatrix(i,j) = corr(predY(:),y_train(:));
        mseMatrix(i,j) = mean((predY(:) - y_train(:)).^2);
        corrMatrixOut(i,j) = corr(predY_test(:),y_test(:));
        mseMatrixOut(i,j) = mean((predY_test(:) - y_test(:)).^2);     
        corrMatrixVal(i,j) = corr(predY_val(:),y_val(:));
        mseMatrixVal(i,j) = mean((predY_val(:) - y_val(:)).^2);
    end
end


[~,ind] = min(mseMatrixVal(:)); 
[v1,v2] = ind2sub([size(mseMatrixVal,1) size(mseMatrixVal,2)],ind);


disp(mseMatrix(v1,v2));
disp(mseMatrixOut(v1,v2));
bestCorr = corrMatrix(v1,v2);
bestCorrOut = corrMatrixOut(v1,v2);

bestMse = mseMatrix(v1,v2);
bestMseOut  = mseMatrixOut(v1,v2);

