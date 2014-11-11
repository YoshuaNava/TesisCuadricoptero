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
radioMotor = diametroMotor/2;


%%%%%   Calculo de momentos de inercia %%%%%

% InerciaCentroEjesXY = (masaCentral * longitudEje^2)/12 + (masaCentral * diametroEje^2)/2;
% InerciaCentroEjeZ = (masaCentral * longitudEje^2)/6;
% InerciaMotorEjesXY = (masaMotor * (diametroMotor/2)^2)/4 + (masaMotor * (alturaMotor)^2)/3;
% InerciaMotorEjeZ = (masaMotor * (diametroMotor/2)^2)/2 + (masaMotor * (longitudEje/2)^2);
% InerciaBateriaEjesXY = (masaCentral * (alturaCajaCentral^2 + anchuraCajaCentral^2))/12;
% InerciaBateriaEjeZ = (masaCentral * 2*anchuraCajaCentral^2)/12;
% 
% 
% InerciaTotalEjesXY = InerciaCentroEjesXY + InerciaMotorEjesXY + InerciaBateriaEjesXY
% InerciaTotalEjeZ = InerciaCentroEjeZ + InerciaMotorEjeZ + InerciaBateriaEjeZ





%%MATRIZ DE INERCIA%%
    %%PITCH%%
        %%MOTORES SOBRE EL EJE(para un motor)%%
        inerciaPitch(1) = 1/12*(masaMotor)*((alturaMotor/2)^2+radioMotor^2);
        %%MOTORES EN EJE OPUESTO (para un motor)%%
        inerciaPitch(2) = 1/12*(masaMotor)*((alturaMotor/2)^2+radioMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaPitch(3) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (alturaCajaCentral^2+anchuraCajaCentral^2);
        %%TOTAL INERCIA PITCH%%
        inercia(1,1)= 2*inerciaPitch(1)+2*inerciaPitch(2) + inerciaPitch(3);
    %%ROLL%%
        %%MOTORES SOBRE EL EJE(para un motor)%%
        inerciaRoll(1) = 1/12*(masaMotor)*((alturaMotor/2)^2+radioMotor^2);
        %%MOTORES EN EJE OPUESTO (para un motor)%%
        inerciaRoll(2) = 1/12*(masaMotor)*((alturaMotor/2)^2+radioMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaRoll(3) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (alturaCajaCentral^2+anchuraCajaCentral^2);
        %%TOTAL INERCIA ROLL%%
        inercia(2,2)= 2*inerciaRoll(1)+2*inerciaRoll(2) + inerciaRoll(3);
     %%YAW%%
        %%PARA CADA MOTOR%%
        inerciaYaw(1) = 1/12*(masaMotor)*(radioMotor^2+radioMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaYaw(2) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (anchuraCajaCentral^2+anchuraCajaCentral^2);
        
        inercia(3,3) = 4 * inerciaYaw(1) + inerciaYaw(2);
        
        
        
