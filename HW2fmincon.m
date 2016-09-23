function [i,r,k,J] = HW2fmincon(r_0,theta)
x_0 = ones(7,1);
x = fmincon(@(x)objFun(x,r_0), x_0,[],[],[],[],[],[],@(x)nonlcon(x,r_0,theta));

% fill in these parts
r = [ r_0 x(1) x(2) x(3) ];
i = [ x(4) x(5) x(6) x(7) ];
k = r - i; %Withdrawal, not year number
J = objFun(x, r_0);

end

function [f] = objFun(x,r_0)
r_1 = x(1);
r_2 = x(2);
r_3 = x(3);


i_0 = x(4);
i_1 = x(5);
i_2 = x(6);
i_3 = x(7);

%fill in this part
f = - ((r_0-i_0) + (r_1-i_1) + (r_2-i_2) + (r_3-i_3));
end



function [h,g] = nonlcon(x,r_0,theta)

r_1 = x(1);
r_2 = x(2);
r_3 = x(3);

i_0 = x(4);
i_1 = x(5);
i_2 = x(6);
i_3 = x(7);

% fill in this part
g = [ theta * i_0 + r_0 - r_1;...
      theta * i_1 + r_1 - r_2; ...
      theta * i_2 + r_2 - r_3 ]; 

% fill in this part
h = [ -i_0;
      -i_1;
      -i_2;
      -i_3;
      i_0 - r_0 ;
      i_1 - r_1;
      i_2 - r_2;
      i_3 - r_3];

end

