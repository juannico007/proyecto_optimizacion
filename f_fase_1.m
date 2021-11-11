function [Ib op]=f_fase_1(c, A, b, verbose)
    %function [Ib op]=f_fase_1(c, A, b, verbose)
    %Función que realiza la primera fase del método de las 2 fases
    %Input:
    %c: Vector fila de costos del problema
    %A: matriz de coeficientes
    %b: Vector columna de restricciones del problema
    %verbose: Booleano que indica si se quiere imprimir todo o no
    %Output:
    %Ib: Indice de la base inicial del problema
    %op: Valor que indica si el problema es óptimo o no 1: Es óptimo
    %                                                   3: No es óptimo


    %Tamaño de A
    [m, n] = size(A);

    %Añado la identidad de tamaño m
    I = eye(m);
    A_2_f = [A I];

    %Costos del problema de la primera fase
    c_2_f = zeros(1, n);
    c_ampliado = ones(1, m);
    c_2_f = [c_2_f c_ampliado];

    %Base de variable artificiales
    Ib = n+1:1:n+m;
    In = 1:1:n;

    %Base para comparar al final
    Ib_og = Ib;
    op = 0;
    it = 1;
    Z = inf;
    Zp = Z;

    %Simplex
    while op == 0
      if verbose
          fprintf('\nIteración en fase 1: %d\n', it);
      end
      [Ib, In, X, Z, op] = f_simplex(Ib, In, A_2_f, c_2_f, b, verbose);
      if verbose
         size_paso = abs(Z-Zp);
         if it >= 2
             if Zp > Z
                 fprintf('La función objetivo disminuyó es decir mejoró en un valor de %.3f\n', size_paso);
             else
                 if Zp < Z
                 fprintf('La función objetivo aumentó es decir empeoró en un valor de %.3f\n', size_paso);
                 else
                     fprintf('El valor de la función objetivo siguió igual\n');
                 end
             end
         end
      end
      it = it + 1;
      Zp = Z;
    end

    if op == 1
      fprintf('Encontramos solución óptima para la fase 1!\n');
    end

    %Si no tengo artificiales en la base, hallé una base inicial
    if ~any(ismember(Ib, Ib_og))
      if verbose
        fprintf('Tenemos una base inicial!\n');
      end
      op = 1;
      return
    end

    %Tomo todos los indices de variables artificiales en esta base
    presente = ismember(Ib, Ib_og);
    ids = find(presente);
    ids = Ib(ids);

    %Si los valores son distintos de 0, el problema no es factible
    if any(X(ids)~=0) || (op == 3)
        disp('Hay variables artificiales distintas de 0 en la base, el problema no es factible');
        op = 0;
        return
    %Sino, saco las artificiales de la base y las reemplazo por
    %estructurales
    else
        if verbose
          disp('Hay variables artificiales iguales a 0 en la base, las reemplazamos por estructurales');
        end
        op = 1;
        Ib = Ib(Ib ~= ids);
        In = In(~ismember(In, Ib_og));
        while size(Ib, 2) ~= m
            id = In(1);
            In = In(In~=id);
            Ib = [Ib id];
        end
        if verbose
          fprintf('Tenemos una base inicial!\n');
        end
    end
end
