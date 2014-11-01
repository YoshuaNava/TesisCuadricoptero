function VisualizacionAnalisisFrecuencia(nombreArchivoCSV, frecuenciaMuestreo)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    anguloPitch = datosArchivo(:,2);
    anguloRoll = datosArchivo(:,3);
    anguloYaw = datosArchivo(:,4);
    velocidadPitch = datosArchivo(:,5);
    velocidadRoll = datosArchivo(:,6);
    velocidadYaw = datosArchivo(:,7);
    velocidadPitch_filtrada = datosArchivo(:,8);
    velocidadRoll_filtrada = datosArchivo(:,9);
    velocidadYaw_filtrada = datosArchivo(:,10);
    aceleracionPitch = datosArchivo(:,11);
    aceleracionRoll = datosArchivo(:,12);
    aceleracionYaw = datosArchivo(:,13);
    aceleracionPitch_filtrada = datosArchivo(:,14);
    aceleracionRoll_filtrada = datosArchivo(:,15);
    aceleracionYaw_filtrada = datosArchivo(:,16);
    posZ = datosArchivo(:,17);
    posZ_filtrada = datosArchivo(:,18);
    velZ = datosArchivo(:,19);
    motorDelantero = datosArchivo(:,20);
    motorTrasero = datosArchivo(:,21);
    motorDerecho = datosArchivo(:,22);
    motorIzquierdo = datosArchivo(:,23);


    
    
    NFFT_senal = 2^nextpow2(numeroDatos);
    f = frecuenciaMuestreo/2*linspace(0,1,NFFT_senal/2+1);
    
    
    figure_angulos = figure('position', [0, 0, 9999, 9999],'name','Angulos')
    subplot(2,3,1)
    plot(anguloPitch)
    title('Pitch')
    if (abs(min(anguloPitch)) > max(anguloPitch))
        ylim([min(anguloPitch) abs(min(anguloPitch))])
    else
        ylim([-max(anguloPitch) 1+max(anguloPitch)])
    end
    xlim([0 length(anguloPitch)])
    subplot(2,3,2)
    plot(anguloRoll)
    title('Roll')
    if (abs(min(anguloRoll)) > max(anguloRoll))
        ylim([min(anguloRoll) abs(min(anguloRoll))])
    else
        ylim([-max(anguloRoll) 1+max(anguloRoll)])
    end
    xlim([0 length(anguloRoll)])
    subplot(2,3,3)
    plot(anguloYaw)
    title('Yaw')
    xlim([0 length(anguloYaw)])
    if (abs(min(anguloYaw)) > max(anguloYaw))
        ylim([min(anguloYaw) abs(min(anguloYaw))])
    else
        ylim([-max(anguloYaw) 1+max(anguloYaw)])
    end
    
    fft_anguloPitch = fft(anguloPitch, NFFT_senal)/numeroDatos;
    fft_anguloRoll = fft(anguloRoll, NFFT_senal)/numeroDatos;
    fft_anguloYaw = fft(anguloYaw, NFFT_senal)/numeroDatos;
    
    subplot(2,3,4)
    plot(f,2*abs(fft_anguloPitch(1:NFFT_senal/2+1)))
    title('Pitch')
    subplot(2,3,5)
    plot(f,2*abs(fft_anguloRoll(1:NFFT_senal/2+1)))
    title('Roll')
    subplot(2,3,6)
    plot(f,2*abs(fft_anguloYaw(1:NFFT_senal/2+1)))
    title('Yaw')
    
    
    
    
    
    
    
    
    
    figure_velocidades_angulares = figure('position', [0, 0, 9999, 9999],'name','Velocidades angulares')
    subplot(2,3,1)
    plot(velocidadPitch)
    title('Pitch')
    if (abs(min(velocidadPitch)) > max(velocidadPitch))
        ylim([min(velocidadPitch) abs(min(velocidadPitch))])
    else
        ylim([-max(velocidadPitch) 1+max(velocidadPitch)])
    end
    xlim([0 length(velocidadPitch)])
    subplot(2,3,2)
    plot(velocidadRoll)
    title('Roll')
    if (abs(min(velocidadRoll)) > max(velocidadRoll))
        ylim([min(velocidadRoll) abs(min(velocidadRoll))])
    else
        ylim([-max(velocidadRoll) 1+max(velocidadRoll)])
    end
    xlim([0 length(velocidadRoll)])
    subplot(2,3,3)
    plot(velocidadYaw)
    title('Yaw')
    xlim([0 length(velocidadYaw)])
    if (abs(min(velocidadYaw)) > max(velocidadYaw))
        ylim([min(velocidadYaw) abs(min(velocidadYaw))])
    else
        ylim([-max(velocidadYaw) 1+max(velocidadYaw)])
    end
    
    
    fft_velocidadPitch = fft(velocidadPitch, NFFT_senal)/numeroDatos;
    fft_velocidadRoll = fft(velocidadRoll, NFFT_senal)/numeroDatos;
    fft_velocidadYaw = fft(velocidadYaw, NFFT_senal)/numeroDatos;
    
    subplot(2,3,4)
    plot(f,2*abs(fft_velocidadPitch(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Pitch')
    subplot(2,3,5)
    plot(f,2*abs(fft_velocidadRoll(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Roll')
    subplot(2,3,6)
    plot(f,2*abs(fft_velocidadYaw(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Yaw')    
    
    
    
    
    
    
    
    
    
    
    figure_velocidades_angulares_filtradas = figure('position', [0, 0, 9999, 9999],'name','Velocidades angulares filtradas')
    subplot(2,3,1)
    plot(velocidadPitch_filtrada)
    title('Pitch filtrada')
    if (abs(min(velocidadPitch_filtrada)) > max(velocidadPitch_filtrada))
        ylim([min(velocidadPitch_filtrada) abs(min(velocidadPitch_filtrada))])
    else
        ylim([-max(velocidadPitch_filtrada) 1+max(velocidadPitch_filtrada)])
    end
    xlim([0 length(velocidadPitch_filtrada)])
    subplot(2,3,2)
    plot(velocidadRoll_filtrada)
    title('Roll filtrada')
    if (abs(min(velocidadRoll_filtrada)) > max(velocidadRoll_filtrada))
        ylim([min(velocidadRoll_filtrada) abs(min(velocidadRoll_filtrada))])
    else
        ylim([-max(velocidadRoll_filtrada) 1+max(velocidadRoll_filtrada)])
    end
    xlim([0 length(velocidadRoll_filtrada)])
    subplot(2,3,3)
    plot(velocidadYaw_filtrada)
    title('Yaw filtrada')
    xlim([0 length(velocidadYaw_filtrada)])
    if (abs(min(velocidadYaw_filtrada)) > max(velocidadYaw_filtrada))
        ylim([min(velocidadYaw_filtrada) abs(min(velocidadYaw_filtrada))])
    else
        ylim([-max(velocidadYaw_filtrada) 1+max(velocidadYaw_filtrada)])
    end
    
    fft_velocidadPitch_filtrada = fft(velocidadPitch_filtrada, NFFT_senal)/numeroDatos;
    fft_velocidadRoll_filtrada = fft(velocidadRoll_filtrada, NFFT_senal)/numeroDatos;
    fft_velocidadYaw_filtrada = fft(velocidadYaw_filtrada, NFFT_senal)/numeroDatos;
    
    subplot(2,3,4)
    plot(f,2*abs(fft_velocidadPitch_filtrada(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Pitch filtrada')
    subplot(2,3,5)
    plot(f,2*abs(fft_velocidadRoll_filtrada(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Roll filtrada')
    subplot(2,3,6)
    plot(f,2*abs(fft_velocidadYaw_filtrada(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Yaw filtrada')
    
    
    
    
    
    
    
    
        
    figure_aceleraciones_angulares = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales')
    subplot(2,3,1)
    plot(aceleracionPitch)
    title('Pitch')
    if (abs(min(aceleracionPitch)) > max(aceleracionPitch))
        ylim([min(aceleracionPitch) abs(min(aceleracionPitch))])
    else
        ylim([-max(aceleracionPitch) 1+max(aceleracionPitch)])
    end
    xlim([0 length(aceleracionPitch)])
    subplot(2,3,2)
    plot(aceleracionRoll)
    title('Roll')
    if (abs(min(aceleracionRoll)) > max(aceleracionRoll))
        ylim([min(aceleracionRoll) abs(min(aceleracionRoll))])
    else
        ylim([-max(aceleracionRoll) 1+max(aceleracionRoll)])
    end
    xlim([0 length(aceleracionRoll)])
    subplot(2,3,3)
    plot(aceleracionYaw)
    title('Yaw')
    xlim([0 length(aceleracionYaw)])
    if (abs(min(aceleracionYaw)) > max(aceleracionYaw))
        ylim([min(aceleracionYaw) abs(min(aceleracionYaw))])
    else
        ylim([-max(aceleracionYaw) 1+max(aceleracionYaw)])
    end
    
    fft_aceleracionPitch = fft(aceleracionPitch, NFFT_senal)/numeroDatos;
    fft_aceleracionRoll = fft(aceleracionRoll, NFFT_senal)/numeroDatos;
    fft_aceleracionYaw = fft(aceleracionYaw, NFFT_senal)/numeroDatos;
    
    subplot(2,3,4)
    plot(f,2*abs(fft_aceleracionPitch(1:NFFT_senal/2+1)))
    title('Pitch')
    subplot(2,3,5)
    plot(f,2*abs(fft_aceleracionRoll(1:NFFT_senal/2+1)))
    title('Roll')
    subplot(2,3,6)
    plot(f,2*abs(fft_aceleracionYaw(1:NFFT_senal/2+1)))
    title('Yaw')
    

    
    
    
    
    
    
    figure_aceleraciones_angulares_filtradas = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales filtradas')
    subplot(2,3,1)
    plot(aceleracionPitch_filtrada)
    title('Pitch filtrada')
    if (abs(min(aceleracionPitch_filtrada)) > max(aceleracionPitch_filtrada))
        ylim([min(aceleracionPitch_filtrada) abs(min(aceleracionPitch_filtrada))])
    else
        ylim([-max(aceleracionPitch_filtrada) 1+max(aceleracionPitch_filtrada)])
    end
    xlim([0 length(aceleracionPitch_filtrada)])
    subplot(2,3,2)
    plot(aceleracionRoll_filtrada)
    title('Roll filtrada')
    if (abs(min(aceleracionRoll_filtrada)) > max(aceleracionRoll_filtrada))
        ylim([min(aceleracionRoll_filtrada) abs(min(aceleracionRoll_filtrada))])
    else
        ylim([-max(aceleracionRoll_filtrada) 1+max(aceleracionRoll_filtrada)])
    end
    xlim([0 length(aceleracionRoll_filtrada)])
    subplot(2,3,3)
    plot(aceleracionYaw_filtrada)
    title('Yaw filtrada')
    xlim([0 length(aceleracionYaw_filtrada)])
    if (abs(min(aceleracionYaw_filtrada)) > max(aceleracionYaw_filtrada))
        ylim([min(aceleracionYaw_filtrada) abs(min(aceleracionYaw_filtrada))])
    else
        ylim([-max(aceleracionYaw_filtrada) 1+max(aceleracionYaw_filtrada)])
    end
    
    fft_aceleracionPitch_filtrada = fft(aceleracionPitch_filtrada, NFFT_senal)/numeroDatos;
    fft_aceleracionRoll_filtrada = fft(aceleracionRoll_filtrada, NFFT_senal)/numeroDatos;
    fft_aceleracionYaw_filtrada = fft(aceleracionYaw_filtrada, NFFT_senal)/numeroDatos;
    
    subplot(2,3,4)
    plot(f,2*abs(fft_aceleracionPitch_filtrada(1:NFFT_senal/2+1)))
    title('Pitch filtrada')
    subplot(2,3,5)
    plot(f,2*abs(fft_aceleracionRoll_filtrada(1:NFFT_senal/2+1)))
    title('Roll filtrada')
    subplot(2,3,6)
    plot(f,2*abs(fft_aceleracionYaw_filtrada(1:NFFT_senal/2+1)))
    title('Yaw filtrada')    
    
    
    
    
    
    figure_posicion_velocidad_z = figure('position', [0, 0, 9999, 9999],'name','Posicion y velocidad en Z (Altura)')
    subplot(2,3,1)
    plot(posZ)
    title('Posicion en Z')
    if (abs(min(posZ)) > max(posZ))
        ylim([min(posZ) abs(min(posZ))])
    else
        ylim([-max(posZ) 1+max(posZ)])
    end
    xlim([0 length(posZ)])
    subplot(2,3,2)
    plot(posZ_filtrada)
    title('Posicion en Z filtrada')
    if (abs(min(posZ_filtrada)) > max(posZ_filtrada))
        ylim([min(posZ_filtrada) abs(min(posZ_filtrada))])
    else
        ylim([-max(posZ_filtrada) 1+max(posZ_filtrada)])
    end
    xlim([0 length(posZ_filtrada)])
    subplot(2,3,3)
    plot(velZ)
    title('Velocidad en Z')
    xlim([0 length(velZ)])
    ylim([0 1+abs(max(velZ))])
    
    fft_posZ = fft(posZ, NFFT_senal)/numeroDatos;
    fft_posZ_filtrada = fft(posZ_filtrada, NFFT_senal)/numeroDatos;
    fft_velZ = fft(velZ, NFFT_senal)/numeroDatos;
    
    subplot(2,3,4)
    plot(f,2*abs(fft_posZ(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Posicion en Z')
    subplot(2,3,5)
    plot(f,2*abs(fft_posZ_filtrada(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Posicion en Z filtrada')
    subplot(2,3,6)
    plot(f,2*abs(fft_velZ(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Velocidad en Z')
end