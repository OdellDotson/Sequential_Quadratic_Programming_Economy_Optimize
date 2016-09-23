function [i,r,k,J] = SQP_Main(r_0,theta)
% exact gradient + hessian

x_k = ones(7,1);
d = x_k;
epsilon = 10^(-6);
k = 0;
while norm(d)>= epsilon
    k = k+1;
    
    H = 2 * hessianf(x_k, r_0);
    f = gradientf(x_k, r_0);
    A = gradienth(x_k, r_0)';
    b = -inCon(x_k, r_0);
    Aeq = gradientg(x_k, theta, r_0)';
    beq = -eqCon(x_k, theta, r_0);
    
    d = quadprog(H,f,A,b,Aeq,beq);
    
    x_k = x_k+d;
end
x = x_k;

r = [ r_0 x(1) x(2) x(3) ];
i = [ x(4) x(5) x(6) x(7) ];
k = r - i; %Withdrawal, not year number
J = objFun(x, r_0);

    function f = objFun(x,r_0)
        r_1 = x(1);
        r_2 = x(2);
        r_3 = x(3);
        i_0 = x(4);
        i_1 = x(5);
        i_2 = x(6);
        i_3 = x(7);
        f = - ((r_0-i_0) + (r_1-i_1) + (r_2-i_2) + (r_3-i_3));
    end

    function gf = gradientf(x,r_0)
        gf = estimateGradient(@(x)objFun(x, r_0), x);
    end

    function B = hessianf(x,r_0)
        B = estimateHessian(@(x)objFun(x, r_0), x);
    end

    function g = eqCon(x,theta,r_0)
        % fill in here. You might or might not have to use all input
        % arguments
        r_1 = x(1);
        r_2 = x(2);
        r_3 = x(3);


        i_0 = x(4);
        i_1 = x(5);
        i_2 = x(6);
        
        g = [theta * i_0 + r_0 - r_1;...
            theta * i_1 + r_1 - r_2; ...
            theta * i_2 + r_2 - r_3 ];
    end

    function gg = gradientg(x,theta,r_0)
        % fill in here. You might or might not have to use all input
        % arguments
        gg = estimateGradient(@(x)eqCon(x, theta, r_0), x);
     
  
    end

    function h = inCon(x,r_0)
        % fill in here. You might or might not have to use all input
        % arguments
        
        r_1 = x(1);
        r_2 = x(2);
        r_3 = x(3);


        i_0 = x(4);
        i_1 = x(5);
        i_2 = x(6);
        i_3 = x(7);
        
        
        h = [ -i_0;
          -i_1;
          -i_2;
          -i_3;
          i_0 - r_0;
          i_1 - r_1;
          i_2 - r_2;
          i_3 - r_3];
    end

    function gh = gradienth(x,r_0)
        % fill in here. You might or might not have to use all input
        % arguments
        gh = estimateGradient(@(x)inCon(x, r_0), x);
    end
    
end