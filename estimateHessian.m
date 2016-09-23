function gf = estimateHessian(f,x)
    gf = estimateGradient(@(x)estimateGradient(f, x), x) 
end