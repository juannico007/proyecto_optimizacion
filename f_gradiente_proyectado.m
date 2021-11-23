function p = f_gradiente_proyectado(f, A, b, p)
    k = 1;
    while 1
        syms x1 x2 x3 al
        check = A*p';
        W = [];

        for i=1:1:10
           %Verifico que el punto inicial sea factible
           if check(i) > b(i)
               disp('Este punto no es factible');
               i
               check(i)
               b(i)
               return
           end
           %Comparacion para el espacio de trabajo
           if check(i) == b(i)
               W = [W i];
           end
        end
        Aw = [];
        %Saco matriz de espacio de trabajo
        for i=1:1:size(W, 2)
           Aw= [Aw; A(W(i),:)];
        end
        Aw;
        %Gradiente
        g(x1, x2, x3) = gradient(f);
        p1 = p(1);
        p2 = p(2);
        p3 = p(3);
        grad = g(p1, p2, p3);

        %Proyector
        P = Aw'*(Aw*Aw')^-1*Aw;
        P = eye(size(P, 2)) - P;

        d = -P*grad;

        if d == 0
            mu = -(Aw*Aw')^-1*Aw*grad;
            if mu >= 0
                return
            else
                min_id = find(mu == min(mu), size(mu, 1));
                W = W(W~=W(min_id));
            end
        else
            al1 = p' + al*d;
            a1 = al1(1);
            a2 = al1(2);
            a3 = al1(3);
            check = A*al1;
            Aal = [];
            for i=1:1:10
               if has(check(i) , al)
                   eq = check(i)==b(i);
                   Aal = [Aal, solve(eq, al)];
               end
            end
            Aal
            Aal = Aal(Aal>0);
            almax = min(Aal);

            h(al) = subs(f, x1, a1);
            h(al) = subs(h, x2, a2);
            h(al) = subs(h, x3, a3);

            almin = newton(h, 0);

            almin = min(almax, almin);
            p = p' + almin*d;
            p = p';

        end
        k = k+1
    end
end
