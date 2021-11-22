function gradiente(f, p)
    e = 0.01;
    syms x y la
    g(x, y) = gradient(f);
    grad = g(p(1), p(2));
    k = 1;
    
    while norm(grad) > e
        d = -grad;
        n = p' + la*d;
        n1 = n(1);
        n2 = n(2);
        h(la) = subs(f, x, n1);
        h(la) = subs(h, y, n2);
        la2 = newton(h, 0);
        p = p' + la2*d;
        p1 = p(1);
        p2 = p(2);
        grad = g(p1, p2);
        k = k+1;
    end
end
