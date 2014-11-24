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

%%MATRIZ DE INERCIA%%
    %%PITCH%%
        %%MOTORES SOBRE EL EJE(para un motor)%%
        inerciaPitch(1) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2);
        %%MOTORES EN EJE OPUESTO (para un motor)%%
        inerciaPitch(2) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaPitch(3) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (alturaCajaCentral^2+anchuraCajaCentral^2);
        %%TOTAL INERCIA PITCH%%
        inercia(1,1)= 2*inerciaPitch(1)+2*inerciaPitch(2) + inerciaPitch(3);
    %%ROLL%%
        %%MOTORES SOBRE EL EJE(para un motor)%%
        inerciaRoll(1) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2);
        %%MOTORES EN EJE OPUESTO (para un motor)%%
        inerciaRoll(2) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaRoll(3) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (alturaCajaCentral^2+anchuraCajaCentral^2);
        %%TOTAL INERCIA ROLL%%
        inercia(2,2)= 2*inerciaRoll(1)+2*inerciaRoll(2) + inerciaRoll(3);
     %%YAW%%
        %%PARA CADA MOTOR%%
        inerciaYaw(1) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaYaw(2) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (anchuraCajaCentral^2+anchuraCajaCentral^2);
        
        inercia(3,3) = 4 * inerciaYaw(1) + inerciaYaw(2);
        
        
        
