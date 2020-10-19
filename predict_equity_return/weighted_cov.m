function c = weighted_cov(x, y, w)
    pd = x.*y;
    exy = wmean(pd, w);
    ex  = wmean(x, w);
    ey  = wmean(y, w);
    c = exy - ex * ey;
end