% evalute models
clearvars -except testStartDates range_params mat_dir prog_params filt_params data_params feat_params resp_params alg_params results_fname ...
  find_optimal_params testDates mode  print_params keep_tstat pts_per_day save_signals save_results tmp_file valDates testIdx pts_per_day simulator
rg_rho_u = [];
rg_rho_w = [];
rg_mse_u = [];
rg_mse_iu = [];
rg_sharpe_u = [];
rg_sharpe_w = [];
rg_rho_iu = [];
rg_rho_iw = [];
rg_nwbeta_u = [];
rg_nwse_u = [];
rg_nwts_u = [];
rg_nwbeta_w = [];
rg_nwse_w = [];
rg_nwts_w = [];
rg_nstocks = [];
rg_avg_nnz = [];
ytest_glued = [];
predytest_glued = [];
cwtest_glued = [];
ytrain_glued = [];
predy_glued = [];
cwtrain_glued = [];
r_u_glued = [];
r_w_glued = [];
nw_rgbeta_u_g = []; % g = glued
nw_rgbeta_w_g = [];
M_stockId_glued = [];
M_all = {};
predY_test_all = {};
stock_mask_all = {};
Xtrain_all = {};
Ytrain_all = {};
Xtest_all = {};
Ytest_all = {};
svd1_all = [];
svd2_all = [];

pre_ytest_list = {} ;
y_test_list = {};
pre_ytrain_list = {};
y_train_list = {};
x_train_list = {};


for i = 1:length(testStartDates)
    
    current_xy_fname = strcat('/xy_', testDates{i}, '.mat');
    current_set =  strcat(mat_dir, current_xy_fname);
    load(current_set);
    disp('current set')
    disp(current_set)
    
    if find_optimal_params == 1
        scan_params   
    end  
 
    
    if mode == 1
        disp('place holder for other baselines')
    elseif mode == 2
        disp('ARRR')
        [predY, predY_test, M] = f_adaptive(Xtrain, ytrain, Xtest, keep_svd1, keep_svd2);
    elseif mode == 3
        disp('Nuclear')
        [predY, predY_test, M] = f_nuclear(Xtrain, ytrain, Xtest, nuclear_lambda);
    elseif mode == 4
        disp('RRR')
        [predY, predY_test, M] = f_rrr(Xtrain, ytrain, Xtest, rrr_rank);
    elseif mode == 6
        disp('ridge_lambda')
        disp(ridge_lambda)
        [predY, predY_test, M] = f_ridge(Xtrain, ytrain, Xtest, ridge_lambda);
    elseif mode == 7
        disp('low_ridge')
        [predY, predY_test, M] = f_low_ridge(Xtrain, ytrain, Xtest,opt_lambda,opt_rnk);
    elseif mode == 8
        disp('lasso')
        [predY, predY_test, M]= f_lasso(Xtrain', ytrain', Xtest',lasso_lambda);
    end
    
    pre_ytest_list{i} = predY_test;
    y_test_list{i} = ytest;
    pre_ytrain_list{i} = predY;
    y_train_list{i} = ytrain;
    x_train_list{i} = Xtrain;
    M_all = [M_all; M];
    
    
    predY_test_all = [predY_test_all; predY_test];
    stock_mask_all = [stock_mask_all; keepIdIdx_mul];
    Xtrain_all = [Xtrain_all; Xtrain];
    Ytrain_all = [Ytrain_all; ytrain];
    Xtest_all = [Xtest_all; Xtest];
    Ytest_all = [Ytest_all; ytest];
    
    evaluate_predy
    
    ytest_glued = [ytest_glued; ytest(:)];
    predytest_glued = [predytest_glued; predY_test(:)];
    cwtest_glued = [cwtest_glued; cwtest(:)];
    ytrain_glued = [ytrain_glued; ytrain(:)];
    predy_glued = [predy_glued; predY(:)];
    cwtrain_glued = [cwtrain_glued; cwtrain(:)];
    r_u_glued = [r_u_glued daily_r_u];
    r_w_glued = [r_w_glued daily_r_w];
    nw_rgbeta_u_g = [nw_rgbeta_u_g; rg_beta_u];
    nw_rgbeta_w_g = [nw_rgbeta_w_g; rg_beta_w];
    M_stockId_glued = union(M_stockId_glued, M_stockId_keepIdx);
    
    rg_rho_u = [rg_rho_u; round(rho_u, 6)];
    rg_rho_w = [rg_rho_w; round(rho_w, 6)];
    rg_sharpe_u = [rg_sharpe_u; round(sharpe_u, 6)];
    rg_sharpe_w = [rg_sharpe_w; round(sharpe_w, 6)];
    rg_rho_iu = [rg_rho_iu; round(rho_iu, 6)];
    rg_rho_iw = [rg_rho_iw; round(rho_iw, 6)];
    rg_nwbeta_u = [rg_nwbeta_u; round(nwbeta_u, 6)];
    rg_nwse_u = [rg_nwse_u; round(nwse_u, 6)];
    rg_nwts_u = [rg_nwts_u; round(nwts_u, 6)];
    rg_nwbeta_w = [rg_nwbeta_w; round(nwbeta_w, 6)];
    rg_nwse_w = [rg_nwse_w; round(nwse_w, 6)];
    rg_nwts_w = [rg_nwts_w; round(nwts_w, 6)];
    rg_nstocks = [rg_nstocks; length(M_stockId_keepIdx)];
    rg_avg_nnz = [rg_avg_nnz; round(mean(sum(predY_test ~= 0, 1)), 6)];
    rg_mse_u = [rg_mse_u;round(mse_u/std(ytest(:)),6)];
    rg_mse_iu = [rg_mse_iu;round(mse_iu/std(ytrain(:)),6)];
end

Rho_u_glued = corrcoef(predytest_glued, ytest_glued);
rho_u_glued = Rho_u_glued(1, 2);
rho_w_glued = wcorrcoef(predytest_glued, ytest_glued, cwtest_glued);
Rho_iu_glued = corrcoef(predy_glued, ytrain_glued);
rho_iu_glued = Rho_iu_glued(1, 2);
rho_iw_glued = wcorrcoef(predy_glued, ytrain_glued, cwtrain_glued);
sharpe_u_glued = nanmean(r_u_glued) / nanstd(r_u_glued) * sqrt(252*pts_per_day);
sharpe_w_glued = nanmean(r_w_glued) / nanstd(r_w_glued) * sqrt(252*pts_per_day);
[nwbeta_u_glued, nwse_u_glued, nwts_u_glued] = newey_west_predy(nw_rgbeta_u_g, 1);
[nwbeta_w_glued, nwse_w_glued, nwts_w_glued] = newey_west_predy(nw_rgbeta_w_g, 1);
mse_iu_glued = mean((predy_glued(:) - ytrain_glued(:)).^2)/mean(ytrain_glued(:).^2);
mse_u_glued = mean((predytest_glued(:) - ytest_glued(:)).^2)/mean(ytest_glued(:).^2);


testDates = [testDates; 'all, glued'];
rg_rho_u = [rg_rho_u; round(rho_u_glued, 6)];
rg_rho_w = [rg_rho_w; round(rho_w_glued, 6)];
rg_mse_u = [rg_mse_u; round(mse_u_glued,6)];
rg_mse_iu = [rg_mse_iu; round(mse_iu_glued,6)]; 
rg_sharpe_u = [rg_sharpe_u; round(sharpe_u_glued, 6)];
rg_sharpe_w = [rg_sharpe_w; round(sharpe_w_glued, 6)];
rg_rho_iu = [rg_rho_iu; round(rho_iu_glued, 6)];
rg_rho_iw = [rg_rho_iw; round(rho_iw_glued, 6)];
rg_nwbeta_u = [rg_nwbeta_u; round(nwbeta_u_glued, 6)];
rg_nwse_u = [rg_nwse_u; round(nwse_u_glued, 6)];
rg_nwts_u = [rg_nwts_u; round(nwts_u_glued, 6)];
rg_nwbeta_w = [rg_nwbeta_w; round(nwbeta_w_glued, 6)];
rg_nwse_w = [rg_nwse_w; round(nwse_w_glued, 6)];
rg_nwts_w = [rg_nwts_w; round(nwts_w_glued, 6)];
rg_nstocks = [rg_nstocks; length(M_stockId_glued)];
rg_avg_nnz = [rg_avg_nnz; round(mean(rg_avg_nnz), 6)];



T = table(rg_nstocks,rg_mse_u, rg_mse_iu, rg_rho_u, rg_rho_w,rg_sharpe_u, rg_sharpe_w,rg_rho_iu, rg_rho_iw, rg_nwbeta_u, rg_nwts_u , rg_nwbeta_w, rg_nwts_w);
T.Properties.RowNames = testDates;
T.Properties.VariableNames = {'N', 'rg_mse_u' 'rg_mse_iu', 'rho_u','rho_w', 'sharpe_u','sharpe_w', 'rho_in_u', 'rho_in_w','nwbeta_u','nw_tstat_u', 'nwbeta_w', 'nw_tstat_w'};

