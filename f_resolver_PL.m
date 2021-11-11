function X=f_resolver_PL(c, A, b, type, verbose)
    %function X=f_resolver_PL(c, A, b, type, verbose)
    %Función que dados los parametros de un PL, encuentra la solución óptima al problema
    %Input:
    %c: Vector fila de costos del problema
    %A: matriz de coeficientes
    %b: Vector columna de restricciones del problema
    %type: Tipo del problema: 'max' o 'min'
    %verbose: Booleano que indica si se quiere imprimir todo o no
    %Output:
    %X: Vector con los valores de la solución óptima, se retorna solo ceros si no tiene solución óptima finita

    %Verficiación del tamaño de los argumentos de la función
    [m,n] = size(A);
    s_b = size(b);
    if s_b(1) ~= m || s_b(2)~=1
       error('La cantidad de restricciones no coincide con las filas de la matriz');
    end
    s_c = size(c);
    if s_c(2) ~= n || s_c(1)~=1
       error('La cantidad de variables no coincide con las columnas de la matriz');
    end

    %Verificación del tipo de problema: máximo o mínimo
    type_og = type;
    if strcmp(type, 'max')
        c = -c;
        type = 'min';
    end
    if ~strcmp(type, 'min')
        error('Debe especificar si el problema es de maximizacion o minimizacion');
    end

    b_neg = find(b < 0, m);
    A(b_neg, :) = -A(b_neg, :);
    b(b_neg) = -b(b_neg);

    %Escoger una base para una primera sol basica facible
    disp('Inicio de la fase 1')
    [Ib, fact] = f_fase_1(c, A, b, verbose);
    X = zeros(1, n);

    if ~fact
      return
    end

    disp('Inicio de la fase 2');
    %Indices base
    I = 1:1:n;
    In = I(~ismember(I,Ib));
    IB = [Ib];
    op = 0;
    it = 1;
    Z = nan;
    Zp = Z;

    %Si no es optima, hacer simplex
     while op==0
         if verbose
             fprintf('\nIteración en fase 2: %d\n', it);
         end
         [Ib, In, X, Z, op]=f_simplex(Ib, In, A, c, b, verbose);
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
             it = it + 1;
             Zp = Z;
         end
     end

    if op == 1
      disp('Encontramos la solución óptima del PL!');
      fprintf('El valor de la funcion objetivo es: %.3f\n', Z);
    end

    disp('Simplex terminado');

    %Si no ha sol optima finita, terminar
    if op==2
        disp('No hay solución óptima finita');
        X = zeros(1, n);
        return
    end
end
