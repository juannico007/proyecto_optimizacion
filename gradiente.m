function gradiente(f, p)
    e = 0.01;
    syms x1 x2 x3 la
    g(x1, x2, x3) = gradient(f);
    grad = g(p(1), p(2), p(3));
    k = 1;
    
    while norm(grad) > e
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
        p1 = p(1);
        p2 = p(2);
        p3 = p(3);
        grad = g(p1, p2, p3);
        k = k+1;
    end
    x = p1;
    y = p2;
    z = p3;
end
