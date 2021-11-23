function y = aurea(f, a, b)
    %Wrapper para una función de sección aurea
    %INPUT: 
    %f: función a minimizar
    %a: limite inferior del intervalo
    %b: limite superior del intervalo
    p = 0.618;
    la = a + (1- p)*(b - a);
    u = a + (p)*(b-a);
    y = seccionaurea(a, b, la, u, p, 1, f);
    return
end
