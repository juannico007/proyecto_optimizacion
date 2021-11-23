function y = aurea(f, a, b)
    p = 0.618;
    la = a + (1- p)*(b - a);
    u = a + (p)*(b-a);
    y = seccionaurea(a, b, la, u, p, 1, f);
    return
end
