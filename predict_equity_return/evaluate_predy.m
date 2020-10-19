% Inputs: predY_test, ytest, wtest, cwtest, predY, ytrain, cwtrain
% Outputs:
%    rho_u, rho_w, sharpe_u, sharpe_w, rho_iu, rho_iw
%    nwbeta_u, nwse_u, nwts_u, nwbeta_w, nwse_w, nwts_w
%    daily_r_u, daily_r_w, rg_beta_u, rg_beta_w

daily_r_u = invest_simulate(predY_test, ones(size(wtest)), ytest); % unweighted
daily_r_w = invest_simulate(predY_test, wtest, ytest); % weighted

Rho_u = corrcoef(predY_test(:), ytest(:));
rho_u = Rho_u(1, 2);
mse_iu = mean((predY(:) - ytrain(:)).^2);
mse_u = mean((predY_test(:) - ytest(:)).^2);

rho_w = wcorrcoef(predY_test(:), ytest(:), cwtest(:));
sharpe_u = nanmean(daily_r_u) / nanstd(daily_r_u) * sqrt(252 * pts_per_day);
sharpe_w = nanmean(daily_r_w) / nanstd(daily_r_w) * sqrt(252 * pts_per_day);

Rho_iu = corrcoef(predY(:), ytrain(:));
rho_iu = Rho_iu(1, 2);
rho_iw = wcorrcoef(predY(:), ytrain(:), cwtrain(:));

rg_beta_u = predy_beta(ytest, predY_test);
[nwbeta_u, nwse_u, nwts_u] = newey_west_predy(rg_beta_u, 1);

rg_beta_w = predy_beta_weighted(ytest, predY_test, wtest);
[nwbeta_w, nwse_w, nwts_w] = newey_west_predy(rg_beta_w, 1);

