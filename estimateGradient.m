function gf = estimateGradient(f,x)

epsilon = 10^(-3);
gf = zeros(numel(x),numel(f(x)));


for n = 1:numel(x) %For every variable X, which is dimension n
    
    %Estimate the gradient along that dimension
    xPermuted = x;
    xPermuted(n) = xPermuted(n) + epsilon;

    fGradientValue = (f(xPermuted) - f(x))/epsilon;

    gf(n,:) = fGradientValue';
    
end

end