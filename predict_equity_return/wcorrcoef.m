%%weighted corrrelation coefficient. 
function rho = wcorrcoef(x, y, w)
    varxy = weighted_cov(x, y, w);
    stdx = sqrt(weighted_cov(x, x, w));
    stdy = sqrt(weighted_cov(y, y, w));
    rho = varxy /(stdx* stdy);
end
