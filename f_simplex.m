function [Ib, In, X, z0, op]=f_simplex(Ib, In, A, c, b, verbose)
    %function [Ib, In, X, z0, op]=f_simplex(Ib, In, A, c, b, verbose)
    %Funcion que realiza una iteración del método Simplex
    %Input:
    %Ib: vector fila de indices de las variables básicas actuales
    %In: vector fila de indices de las variables no básicas actuales
    %A: matriz de coeficientes
    %c: Vector fila de costos del problema
    %b: Vector columna de restricciones del problema
    %Verbose: Booleano que indica si se quiere imprimir todo o no
    %Output:
    %Ib: vector fila de indices de las nuevas variables básicas
    %In: vector fila de indices de las nuevas variables no básicas
    %X: Vector fila con los valores de la solución básica con la base de entrada
    %z0: Valor de la función objetivo con la base de entrada
    %op: Valor que indica si termina simplex o no 0: no es la solución óptima
    %                                             1: es la solución óptima
    %                                             2: no hay solución óptima
    %                                             3: el problema no es factible


    %Variables de la iteracion
    [m, n] = size(A);
    B = A(:, Ib);
    N = A(:, In);
    Cb = c(:, Ib);
    Cn = c(:, In);
    Xb = inv(B)*b;

    %Inicializo con 0 y en caso de que no sea optima no cambio esto
    X = zeros(1, n);
    z0 = 0;

    %Lleno los valores del vector a retornar
    sz = size(Ib, 2);
    for i=1:1:sz
      id = Ib(i);
      X(id) = Xb(i);
    end

    %Valor de la F.O
    z0 = Cb*Xb;

    if verbose
        if size(Ib) == 1
          fprintf('Indices básicos: [%g] \n', Ib(1:end-1));
        else
          fprintf('Indices básicos: [');
          fprintf('%g, ', Ib(1:end-1))
          fprintf('%g] \n', Ib(end));
        end
%         if size(In, 2) == 1
%           fprintf('Indices no básicos: [%g] \n', In(1:end-1));
%         else
%           fprintf('Indices no básicos: [');
%           fprintf('%g, ', In(1:end-1))
%           fprintf('%g] \n', In(end));
%         end

        disp('Solución básica: ');
        disp(X);
        fprintf('Valor de la F.O %.3f \n', z0);
    end


    %Si tengo alguna X negativa, rompo con no negatividad y no es optima
    if any(Xb < 0)
       if verbose
          disp('El problema no tiene solución');
       end
       op = 3;
       return
    end

    %Saco costos reducidos
    Cj = Cn - Cb*inv(B)*N;
%     if verbose
%         fprintf('Costos reducidos: [');
%         fprintf('%g, ', Cj(1:end-1))
%         fprintf('%g] \n', Cj(end));
%     end

    %Reviso si es optima y sino, saco el costo reducido con menor valor
    min_cj = min(Cj);
    if min_cj > 0
      op = 1;
      return
    else
        if min_cj == 0
          op = 1;
          disp('El PL tiene múltiples soluciones');
          return
        end
    end


    if verbose
      disp('La solucion no es optima');
    end

    op = 0;

    %Los indices que contienen el menor costo reducido
    k_id = find(Cj == min_cj, size(Cj, 2));
    %Determino quien entra a la base
    k = In(k_id);

    %En caso de repeticion hago regla de Bland
    if size(k_id, 2) > 1
      k_ids = In(k_id);
      k = min(k_ids);
    end


%     if verbose
%       fprintf('El indice de la variable candidata a entrar a la base es %d\n', k);
%     end

    %Hago criterio de la razón mínima
    yk = inv(B)*A(:, k);

    %Si todos los Yk son negativos no hay solución óptima fínita
    if max(yk) <= 0
      op = 2;
      return
    end
    %Saco by y anulo los negativos
    yk(yk<=0) = nan;
    by = Xb./yk;

    %Tomo los indices con el menor valor
    r_id = find(by == min(by), size(by, 1));

    %En caso de ser necesario hago regla lexicográfica
    while size(r_id, 1) > 1
      r_ids = Ib(r_id);
      r_id = min(r_ids);
      y_1 = inv(B)*A(:, r_id);
      y_1(y_1<=0) = nan;
      by = y_1./yk;
      r_id = find(by == min(by), size(by, 1));
    end

    %Determino quien sale de la base
    r = Ib(r_id);
%     if verbose
%       fprintf('El indice de la variable que sale de la base es %d\n', r);
%     end

    %Cambio de base
    Ib = Ib(Ib ~= r);
    In = In(In ~= k);
    Ib = [Ib k];
    In = [In r];
    Ib = sort(Ib);
    In = sort(In);
end
