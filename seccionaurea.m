function v = seccionaurea(a, b, la, u, p, i, f)
    %Función de seccion aurea para realizar una búsqueda de linea
    %INPUT:
    %a: limite inferior del intervalo
    %b: limite superior del intervalo
    %la: lambda calculado en el intervalo
    %u: mu calculado en el intervalo
    %p: constante phi
    %i: número de la iteración
    %g: función a minimizar
    %OUTPUT:
    %Punto mínimo de la función en el intervalo
    
    %Si el intervalo es lo suficietemente pequeño
    if b - a <= 0.01
        v = la;
    %Sino actualiza
    else
        if f(la) >= f(u)
            a = la;
            la = u;
            u = a + p*(b -a);
            v = seccionaurea(a, b, la, u, p, i + 1,f);
        else
            b = u;
            u = la;
            la = a + (1 - p)*(b - a);
            v = seccionaurea(a, b, la, u, p, i + 1,f);
        end
    end
    return 
end
