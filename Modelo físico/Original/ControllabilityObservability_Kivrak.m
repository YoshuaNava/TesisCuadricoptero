LazoAbierto_Kivrak()

matrizObservabilidad = obsv(sys);
estadosNoObservables = length(A) - rank(matrizObservabilidad)

matrizControlabilidad = ctrb(sys);
estadosNoControlables = length(A) - rank(matrizControlabilidad)

polos_A = eig(A)

%[NUM_laplace, DEN_laplace] = ss2tf(A, B, C, D, 4)