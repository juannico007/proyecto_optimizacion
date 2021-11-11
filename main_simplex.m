% Optima finita

disp(f_resolver_PL([1 1 0 0 0], [-1 1 1 0 0; 2 5 0 1 0; 2 -1 0 0 1], [4; 20; 2], 'max', 1))

% disp(f_resolver_PL([-2 -1 -3 0 0], [1 2 1 1 0; -2 2 2 0 1], [3; 3], 'min', 0))


% Optima no finita

% disp(f_resolver_PL([1 2 1 0], [1 -2 1 0; -1 1 3 1], [6; 3], 'max', 0))

% disp(f_resolver_PL([-1 -3 0 0], [1 -2 1 0;-1 1 0 1], [4; 3], 'min', 0))


% Multiples soluciones

% disp(f_resolver_PL([1 1 1 0 0], [1 2 6 1 0; 2 4 2 0 1], [2; 2], 'max', 0))


% disp(f_resolver_PL([-2 -4 0 0], [1 2 1 0; -1 1 0 1], [4; 1], 'min', 0));


% No factible

% disp(f_resolver_PL([2 3 0 0 0], [1 2 1 0 0; -2 3 0 -1 0; 1 0 0 0 -1], [4; 6; 4], 'min', 0))

% disp(f_resolver_PL([1 1 0 0 0], [6 5 -1 0 0;20 20 0 1 0; 0 1 0 0 -1], [300; 100; 30], 'max', 0))
