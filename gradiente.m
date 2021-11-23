function [x, y, z] = gradiente()
    syms x1 x2 x3 la
    ro = 1000000000000000000;
    p = [0 0 0];
%    f = (x1-5)^2 + (x2-4)^2 +(x3-3)^2;
    f = ((x3 + x2^2 + x1^2) + (44*x1 + 72*x2 + 95*x3) + ro*((44*x1 + 72*x2 + 95*x3 - 7000)^2 +(-40*x1 -60*x2 -80*x3 + 5700)^2+(-x1-x2-x3+75)^2+(x1 - 50)^2+(-x1+15)^2 +(x2 - 50)^2+(-x2+20)^2 +(x3 - 50)^2+(-x3+10)^2));
    e = 1;
    g(x1, x2, x3) = gradient(f);
    grad = g(p(1), p(2), p(3));
    k = 1;
    
    while k < 15
        norm(grad);
        d = -grad;
        n = p' + la*d;
        n1 = n(1);
        n2 = n(2);
        n3 = n(3);
        h(la) = subs(f, x1, n1);
        h(la) = subs(h, x2, n2);
        h(la) = subs(h, x3, n3);
        la2 = newton(h, 0);
        p = p' + la2*d;
        p = p';
        p1 = round(p(1));
        p2 = round(p(2));
        p3 = round(p(3));
        grad = g(p1, p2, p3);
        k = k+1
        
        
    end
    x = ceil(p1)
    y = ceil(p2)
    z = ceil(p3)
end
