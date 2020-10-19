function [nwbeta, nwse, nwts] = newey_west_predy(rg_beta, nw_choice)
    T = length(rg_beta);
    % regression: beta_t = nwbeta * x_t + epsilon_t, where x_t = 1 for all t
    % compute nwbeta and its standard error, and try to reject H_0: nwbeta = 0
    x = ones(T, 1);
    L = floor(4*(T/100)^(2/9)); % following NeweyWest.m
    if nw_choice == 1
        nwbeta = x \ rg_beta;
        err = rg_beta - x*nwbeta;
        nwse = NeweyWest(err, x, L, 0);
        nwts = nwbeta / nwse;
    else
        [nwbeta, ~, ~, ~, ~, ~, nwse, ~, ~, nwts, ~, ~] = olshac(rg_beta, x, L, L);
    end
end

