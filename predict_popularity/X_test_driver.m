% select the mode to test different methods
% The input has the training(x_train, y_train), validation(x_val, y_val) and testing dataset(x_test,y_test).
% take x_train and y_train for example. [d1,n] = size(x_train); [d2,n] = size(y_train)
% The output is the in-sample and out-of-sample MSE and correlation using
% the chosen parameters from best performance in validation dataset
    
mode = 4;

for file_id = 1:10
    current_file = num2str(file_id) +"_tweets.mat";
    load(current_file);
    current_time = datestr(now,'mm-dd-yyyy-HH-MM-SS');
    
    if mode == 1
        X_test_adaptive        
        matfile = "adaptive" + num2str(file_id) + current_time +'.mat';
        
    elseif mode == 2       
        X_test_low_ridge
        matfile =  "lowridge" + num2str(file_id) + current_time +'.mat';
               
    elseif mode == 3       
        X_test_nuclear
        matfile =  "nuclear" + num2str(file_id) + current_time +'.mat';
        
    elseif mode == 4
        X_test_ridge
        matfile =  "ridge" + num2str(file_id)  + current_time +'.mat';
       
    elseif mode == 5
        X_test_lasso
        matfile =  "lasso" + num2str(file_id) + current_time +'.mat';
    
    elseif mode == 6
        X_test_rrr
        matfile =  "rrr" + + num2str(file_id) + current_time +'.mat';   
    end
    save(matfile);
    clearvars -except file_id
end

