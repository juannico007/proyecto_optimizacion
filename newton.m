function op = newton(f, p)
    
    k = 1;

    x(k) =  p;

    e = 0.001;
    syms la
    f1(la) = diff(f, 1);

    f2(la) = diff(f, 2);

    y1 = f1(x(k));
    y2 = f2(x(k));

    x(k+1) = x(k)-(y1/y2);

    while abs(x(k+1) - x(k)) > e
    
        k = k+1;
    
        y1 = f1(x(k));
        y2 = f2(x(k));

        x(k+1) = x(k)-(y1/y2);
    
    end
    
    op = x(k+1);
    return
end
