A = [1, 0, 0,1,0,0,0,0,0,0,0,0,0; 
     0, 1, 0,0,1, 0,0,0,0,0,0,0,0; 
     0, 0, 1,0,0,1,0,0,0,0,0,0,0; 
     -1, 0, 0,0,0,0,1,0,0,0,0,0,0; 
     0, -1, 0,0,0,0,0,1,0,0,0,0,0; 
     0, 0, -1,0,0,0,0,0,1,0,0,0,0; 
     44, 72, 95,0,0,0,0,0,0,1,0,0,0; 
     -1, 0, 2,0,0,0,0,0,0,0,1,0,0; 
     -40, -60, -80,0,0,0,0,0,0,0,0,1,0;
     -1,-1,-1,0,0,0,0,0,0,0,0,0,1];
 c = [44,72,95,0,0,0,0,0,0,0,0,0,0];
 b = [50; 50; 50; -25; -20; -10; 10000; 0; -5700; -120];
 f_resolver_PL(c, A, b, 'min', 0)