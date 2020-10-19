function [v1, v2] = find_optima_adaptive(Xtrain, ytrain, Xtest, ytest)  
    rg_svd_d1 = 1:1:50;
    rg_svd_d2 = 1:1:30;
    n_d1 = length(rg_svd_d1);
    n_d2 = length(rg_svd_d2);
    errorMatrix = zeros(n_d1, n_d2);
    for i = 1:n_d1
        for j = 1:n_d2
            svd_d1 = rg_svd_d1(i);
            svd_d2 = rg_svd_d2(j);
            [~, predY_test,~] = f_adaptive(Xtrain, ytrain, Xtest, svd_d1, svd_d2);
            errorMatrix(i,j) = norm(ytest(:) - predY_test(:));   
        end
    end
    [~,ind] = min(errorMatrix(:)); 
    [v1,v2] = ind2sub([size(errorMatrix,1) size(errorMatrix,2)],ind);
end