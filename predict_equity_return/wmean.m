function m = wmean(x, w)
    m = sum(x.*w)/sum(w);
end