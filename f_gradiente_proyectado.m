function p = f_gradiente_proyectado(f, A, b, p)
    %Función que realiza el método de gradiente proyectado para minimizar
    %una función
    %INPUT: 
    %f: Función a minimizar, para su funcionamiento debe de estar en
    %términos de x1 x2 y x3
    %A: Matriz de restricciones
    %b: Vector de restricciones
    %p: Punto inicial
    
    %Iteracion actual
    k = 1;
    %Variable de control para la actualización del espacio de trabajo
    m = 1;
    %Espacio de trabajo
    W = [];
    
    %Se iterará 11 veces debido a que converge muy lento
    while k < 11
        syms x1 x2 x3 al
        %Vector para verificar que restricciones están activas
        check = A*p';
        p;
        
        %Si se debe actualizar el espacio de trabajo
        if m == 1
            W = [];
            for i=1:1:9
               %Verifico que el punto sea factible
               if check(i) > b(i)
                   disp('Este punto no es factible');
                   i;
                   check(i);
                   b(i);
                   return
               end
               %Comparacion para el espacio de trabajo
               if check(i) == b(i)
                   W = [W i];
               end
            end   
        end
        
        %Matriz de espacio de trabajo
        Aw = []; 
        m = 1;
        %Saco matriz de espacio de trabajo
        for i=1:1:size(W, 2)
           Aw= [Aw; A(W(i),:)];
        end
        Aw;
        W;
        %Gradiente
        g(x1, x2, x3) = gradient(f);
        p1 = p(1);
        p2 = p(2);
        p3 = p(3);
        %Evaluado en el punto
        grad = g(p1, p2, p3);

        %Proyector
        P = Aw'*((Aw*Aw')^-1)*Aw;
        %Redondea para evitar conflictos con la dirección
        P = round(P);
        P = eye(size(P, 2)) - P;
        %Direccion
        d = -P*grad;

        %Si la dirección es 0
        if d == 0
            %disp("caso direccion 0")
            %Saco mu
            mu = -(Aw*Aw')^-1*Aw*grad;
            
            %si es mayor a 0 paro
            if mu >= 0
                return
            %Sino saco la variable dual mas negativa del espacio de trabajo
            else
                min_id = find(mu == min(mu), size(mu, 1));
                W = W(W~=W(min_id));
                m = 0;
            end
        %Sino
        else
            %disp("caso direccion no 0")
            %Saco el alpha máximo que me mantenga en el espacio factible
            al1 = p' + al*d;
            a1 = al1(1);
            a2 = al1(2);
            a3 = al1(3);
            check = A*al1;
            Aal = [];
            %Calculo alphas que me levan a la frontera en cada restriccion
            for i=1:1:9
               if has(check(i) , al)
                   eq = check(i)==b(i);
                   Aal = [Aal, solve(eq, al)];
               end
            end
%             Aal
            %Elimino alphas de forma >=
            Aal = Aal(Aal>0);
            %Obtengo el mínimo de esos que me mantiene sobre las
            %restricciones
            almax = min(Aal);
%             if almax > 1
%                 almax = 1;
%             end
            almax;
            %Reescribo la función en términos de alpha
            h(al) = subs(f, x1, a1);
            h(al) = subs(h, x2, a2);
            h(al) = subs(h, x3, a3);

%             almin = newton(h, 0)
            %Minimizo la función en el intervalo [0, alpha]
            almin = aurea(h,0, almax);
            %Actualizo el punto
            p = p' + almin*d;
            p = p';

        end
        %Sumo 1 en la iteración
        k = k+1
    end
    %Redondeo el punto y termino
    p = round(p);
end
