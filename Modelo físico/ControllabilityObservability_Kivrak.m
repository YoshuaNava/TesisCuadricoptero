matrizObservabilidad = obsv(sys);
unob = length(A) - rank(matrizObservabilidad)

matrizControlabilidad = ctrb(sys);
unco = length(A) - rank(matrizControlabilidad)