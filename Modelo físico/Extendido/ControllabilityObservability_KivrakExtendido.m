LazoAbierto_KivrakExtendido()

matrizObservabilidad = obsv(sys);
estadosNoObservables = length(A) - rank(matrizObservabilidad)

matrizControlabilidad = ctrb(sys);
estadosNoControlables = length(A) - rank(matrizControlabilidad)

polos_A = eig(A)