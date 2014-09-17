%%%%%   Parametros del cuadricoptero   %%%%%
masaBateriaPequena = 0.0265;
masaBateriaGrande = 0.090;
masaBaseAnime = 0.0075;
masaMotor = 0.051;
masaUltrasonido = 0.009;
masaChasisCircuitos = 0.482;
masaTotal = 0.6;
masaCentral = 0.23;
longitudAspa = 0.31;
longitudEje =  0.47;
alturaMotor = 0.095;
diametroMotor = 0.025;
diametroEje = 0.005;
alturaCajaCentral = 0.1;
anchuraCajaCentral = 0.09;

%%%%%   Calculo de momentos de inercia   %%%%%

InerciaCentroEjesXY = (masaCentral * longitudEje^2)/12 + (masaCentral * diametroEje^2)/2;
InerciaCentroEjeZ = (masaCentral * longitudEje^2)/6;
InerciaMotorEjesXY = (masaMotor * (diametroMotor/2)^2)/4 + (masaMotor * (alturaMotor)^2)/3;
InerciaMotorEjeZ = (masaMotor * (diametroMotor/2)^2)/2 + (masaMotor * (longitudEje/2)^2);
InerciaBateriaEjesXY = (masaCentral * (alturaCajaCentral^2 + anchuraCajaCentral^2))/12;
InerciaBateriaEjeZ = (masaCentral * 2*anchuraCajaCentral^2)/12;


InerciaTotalEjesXY = InerciaCentroEjesXY + InerciaMotorEjesXY + InerciaBateriaEjesXY
InerciaTotalEjeZ = InerciaCentroEjeZ + InerciaMotorEjeZ + InerciaBateriaEjeZ

