function rg_beta = predy_beta(Y, Y_hat)
    [N, T] = size(Y);
    rg_beta = [];
    for t=1:T
        beta = Y_hat(:,t) \ Y(:,t);
        rg_beta = [rg_beta; beta];
    end
end

