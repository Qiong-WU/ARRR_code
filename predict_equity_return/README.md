# Introduction

This directory contains source code for the models predicting equity returns. 
 
1. unified_run.m runs algorithms and gets results. Set variable "mode" to test different methods.

2. The scan_params_in_algorithm folder contains the scripts to scan parameters for each algorithm (ARRR, Ridge, low-rank ridge, Lasso, Nuclear norm, RRR)

3. The algorithm folder has the implementation of all the methods. Our algorithm is implemented in f_adaptive.m

## Dataset:
Our dataset is purchased from 3rd party vendors. They are available in major platforms such as quandl. We are prohibited from re-distributing the data. Here, we provide a sample data to illustrate the format of our input in sample_stock.mat. 
Below describe the variables appeared in this file. 
base_date is the list of dates. We extracted 100 trading dates in 2010, from 20100104 to 20100601 and sampled 300 stocks.
For example, M_aret10d(300*100) is the matrix of the past 10-day return matrix. Each row represents a stock and each column represents a trading day. The corresponding stock ids are in base_equity(300*1) and the corresponding dates are in base_date(100*1). M_dv(300*100) is the dollar volume matrix.

## Public packages:

For the Newey-West function in the evaluate_predy.m, we used the package from  
https://au.mathworks.com/matlabcentral/fileexchange/41275-newey-west-standard-errors?focused=3810088&tab=function
For nuclear norm solver, we used the NNLS package [1].  
The package is available at https://blog.nus.edu.sg/mattohkc/softwares/nnls/

## Reference:
[1] K.C. Toh, and S.W. Yun    
    An accelerated proximal gradient algorithm for nuclear norm regularized 
    least squares problems
