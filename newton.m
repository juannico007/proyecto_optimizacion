function op = newton(f, p) %Input: Una función y un punto inicial
                           %Outpu: el punto minimo optimo de la funcion
                           
                           %Se utilizo como base codigo del metodo de Newton echo junto al profesor en el horario de clase
    
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
