syms x1 x2 x3
%Funcion a minimizar
f = (x3/8 + (x2/6)^2 + (x1/4)^2) + (44*x1 + 72*x2 + 95*x3);
%Matriz de restricciones
A = [44 72 95;
    -40 -60 -80;
    -1 -1 -1;
    1 0 0;
    -1 0 0;
    0 1 0;
    0 -1 0;
    0 0 1;
    0 0 -1];
%Vector de restricciones
b = [7000; -5100; -75; 50; -15; 50; -20; 50; -10];
f_gradiente_proyectado(f, A, b, [25 20 40])
