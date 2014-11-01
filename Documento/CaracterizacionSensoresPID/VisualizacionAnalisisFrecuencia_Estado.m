function VisualizacionAnalisisFrecuencia(nombreArchivoCSV, frecuenciaMuestreo)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    anguloPitch = datosArchivo(:,2);
    anguloRoll = datosArchivo(:,3);
    anguloYaw = datosArchivo(:,4);
    velocidadPitch = datosArchivo(:,5);
    velocidadRoll = datosArchivo(:,6);
    velocidadYaw = datosArchivo(:,7);
    posZ = datosArchivo(:,8);

    
    
    
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
        
    
    
    
    figure_posicion_velocidad_z = figure('position', [0, 0, 9999, 9999],'name','Posicion y velocidad en Z (Altura)')
    subplot(2,2,1)
    plot(posZ)
    title('Posicion en Z')
    if (abs(min(posZ)) > max(posZ))
        ylim([min(posZ) abs(min(posZ))])
    else
        ylim([-max(posZ) 1+max(posZ)])
    end
%     xlim([0 length(posZ)])
%     subplot(2,2,2)
%     plot(velZ)
%     title('Velocidad en Z')
%     xlim([0 length(velZ)])
%     ylim([0 1+abs(max(velZ))])
    
    fft_posZ = fft(posZ, NFFT_senal)/numeroDatos;
%    fft_velZ = fft(velZ, NFFT_senal)/numeroDatos;
    
    subplot(2,2,3)
    plot(f,2*abs(fft_posZ(1:NFFT_senal/2+1)))
    ylim([0 5])
    title('Posicion en Z')
%     subplot(2,2,4)
%     plot(f,2*abs(fft_velZ(1:NFFT_senal/2+1)))
%     ylim([0 5])
%     title('Velocidad en Z')  
end