syms x1 x2 x3 
ro = 1000000000000000000;

%fo = ((x3^4 + x2^2 + x1) + (44*x1 + 72*x2 + 95*x3) + ro*((44*x1 + 72*x2 + 95*x3 - 7000)^2 +(-40*x1 -60*x2 - -80*x3 + 5700)^2+(-x1-x2-x3+75)^2+(2*x3 - x1)^2+(x1 - 50)^2+(-x1+25)^2 +(x2 - 50)^2+(-x2+20)^2 +(x3 - 50)^2+(-x3+10)^2));
%fo = x
[a b c] = gradiente()
