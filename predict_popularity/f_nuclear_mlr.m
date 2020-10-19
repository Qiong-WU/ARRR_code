function X = f_nuclear_mlr(H, G, mu)
    %change it for n < d1
    %nr = size(H, 1);
    nc = size(H, 2);
    d1 = size(G, 2);
    nr = d1;
    %G = G(1:nr,1:nr);
    G = [G; zeros(d1-nr,d1)];
    H = [H; zeros(d1-nr,d1)];
    bb = H(:);
    Amap  = @(X) Amap_MLR(X,G);
    ATmap = @(y) ATmap_MLR(y,G);
    B = ATmap(bb);
    options.tol = 1e-8;

    %mumax = svds(sparse(B),1,'L',options);
    %mu_scaling = 1e-4;
    %mutarget   = mu_scaling*mumax;
    %par.continuation_scaling = mu_scaling;
    mutarget = mu;

    par.tol     = 1e-4;
    par.verbose = 0;
    par.plotyes = 0;
    par.truncation       = 1;
    par.truncation_gap   = 20;
    par.maxiter  = 200;
    problem_type = 'NNLS';
    [beta,iter,time,sd,hist] = ...
        APGL(nr,nc,problem_type,Amap,ATmap,bb,mutarget,0,par);  
    
    if sum(class(beta) == 'struct') == 6
        X = beta.U*beta.V';
    else
        X = beta;
    end
    
end
