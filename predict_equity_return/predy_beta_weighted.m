function rg_beta = predy_beta_weighted(Y, Y_hat, W)
    [N, T] = size(Y);
    rg_beta = [];
    for t=1:T
        beta = (W(:,t).*Y_hat(:,t)) \ (W(:,t).*Y(:,t));
        rg_beta = [rg_beta; beta];
    end
end

