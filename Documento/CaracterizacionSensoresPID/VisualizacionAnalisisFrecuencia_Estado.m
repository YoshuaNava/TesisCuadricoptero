function [f, pitch, roll, yaw] = VisualizacionAnalisisFrecuencia(nombreArchivoCSV, frecuenciaMuestreo)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    anguloPitch = datosArchivo(:,2);
    anguloRoll = datosArchivo(:,3);
    anguloYaw = datosArchivo(:,4);
    velocidadPitch = datosArchivo(:,5);
    velocidadRoll = datosArchivo(:,6);
    velocidadYaw = datosArchivo(:,7);
    posZ = datosArchivo(:,8);

    
    
    
    
    
    figure_angulos = figure('position', [0, 0, 9999, 9999],'name','Angulos')
    subplot(2,3,1)
    plot(anguloPitch)
    title('Pitch')
    if (abs(min(anguloPitch)) > max(anguloPitch))
        ylim([min(anguloPitch) abs(min(anguloPitch))])
    else
        ylim([-max(anguloPitch) max(anguloPitch)])
    end
    xlim([0 length(anguloPitch)])
    subplot(2,3,2)
    plot(anguloRoll)
    title('Roll')
    if (abs(min(anguloRoll)) > max(anguloRoll))
        ylim([min(anguloRoll) abs(min(anguloRoll))])
    else
        ylim([-max(anguloRoll) max(anguloRoll)])
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
    
    %lol
    
    fft_anguloPitch = fft(anguloPitch, numeroDatos);
    fft_anguloRoll = fft(anguloRoll, numeroDatos);
    fft_anguloYaw = fft(anguloYaw, numeroDatos);
    
    fft_anguloPitch = fftshift(fft_anguloPitch, numeroDatos);
    fft_anguloRoll = fftshift(fft_anguloRoll, numeroDatos);
    fft_anguloYaw = fftshift(fft_anguloYaw, numeroDatos);
    amplitud_fft_anguloPitch = abs(fft_anguloPitch);
    amplitud_fft_anguloRoll = abs(fft_anguloRoll);
    amplitud_fft_anguloYaw = abs(fft_anguloYaw);
    longitud_fft = length(amplitud_fft_anguloPitch);
    shift_amplitud_fft_anguloPitch = amplitud_fft_anguloPitch / longitud_fft;
    shift_amplitud_fft_anguloRoll = amplitud_fft_anguloRoll / longitud_fft;
    shift_amplitud_fft_anguloYaw = amplitud_fft_anguloYaw / longitud_fft;
    maximoValor = max([max(shift_amplitud_fft_anguloPitch(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_anguloRoll(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_anguloYaw(longitud_fft/2:longitud_fft))]);
    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    
    subplot(2,3,4)
    plot(f,shift_amplitud_fft_anguloPitch)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Pitch')
    subplot(2,3,5)
    plot(f,shift_amplitud_fft_anguloRoll)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Roll')
    subplot(2,3,6)
    plot(f,shift_amplitud_fft_anguloYaw)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Yaw')
    
    pitch = shift_amplitud_fft_anguloPitch;
    roll = shift_amplitud_fft_anguloRoll;
    yaw = shift_amplitud_fft_anguloYaw; 
    
    
    
    
    
    
    
    
    
    figure_velocidades_angulares = figure('position', [0, 0, 9999, 9999],'name','Velocidades angulares')
    subplot(2,3,1)
    plot(velocidadPitch)
    title('Pitch')
    if (abs(min(velocidadPitch)) > max(velocidadPitch))
        ylim([min(velocidadPitch) abs(min(velocidadPitch))])
    else
        ylim([-max(velocidadPitch) max(velocidadPitch)])
    end
    xlim([0 length(velocidadPitch)])
    subplot(2,3,2)
    plot(velocidadRoll)
    title('Roll')
    if (abs(min(velocidadRoll)) > max(velocidadRoll))
        ylim([min(velocidadRoll) abs(min(velocidadRoll))])
    else
        ylim([-max(velocidadRoll) max(velocidadRoll)])
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
    
    %lol
    
    fft_velocidadPitch = fft(velocidadPitch, numeroDatos);
    fft_velocidadRoll = fft(velocidadRoll, numeroDatos);
    fft_velocidadYaw = fft(velocidadYaw, numeroDatos);
    
    fft_velocidadPitch = fftshift(fft_velocidadPitch, numeroDatos);
    fft_velocidadRoll = fftshift(fft_velocidadRoll, numeroDatos);
    fft_velocidadYaw = fftshift(fft_velocidadYaw, numeroDatos);
    amplitud_fft_velocidadPitch = abs(fft_velocidadPitch);
    amplitud_fft_velocidadRoll = abs(fft_velocidadRoll);
    amplitud_fft_velocidadYaw = abs(fft_velocidadYaw);
    longitud_fft = length(amplitud_fft_velocidadPitch);
    shift_amplitud_fft_velocidadPitch = amplitud_fft_velocidadPitch / longitud_fft;
    shift_amplitud_fft_velocidadRoll = amplitud_fft_velocidadRoll / longitud_fft;
    shift_amplitud_fft_velocidadYaw = amplitud_fft_velocidadYaw / longitud_fft;
    maximoValor = max([max(shift_amplitud_fft_velocidadPitch(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_velocidadRoll(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_velocidadYaw(longitud_fft/2:longitud_fft))]);

    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    
    subplot(2,3,4)
    plot(f,shift_amplitud_fft_velocidadPitch)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Pitch')
    subplot(2,3,5)
    plot(f,shift_amplitud_fft_velocidadRoll)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Roll')
    subplot(2,3,6)
    plot(f,shift_amplitud_fft_velocidadYaw)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Yaw')
    
    pitch = shift_amplitud_fft_velocidadPitch;
    roll = shift_amplitud_fft_velocidadRoll;
    yaw = shift_amplitud_fft_velocidadYaw;
    
    
    
   
    
    
    
    
    
    figure_aceleraciones_angulares_filtradas = figure('position', [0, 0, 9999, 9999],'name','Posicion en Z (Altura)')
    subplot(1,2,1)
    plot(posZ)
    title('Posicion en Z')
    if (abs(min(posZ)) > max(posZ))
        ylim([min(posZ) abs(min(posZ))])
    else
        ylim([-max(posZ) 1+max(posZ)])
    end
    xlim([0 length(posZ)])

    
    fft_posZ = fft(posZ, numeroDatos);
    
    fft_posZ = fftshift(fft_posZ, numeroDatos);
    amplitud_fft_posZ = abs(fft_posZ);
    longitud_fft = length(amplitud_fft_posZ);
    shift_amplitud_fft_posZ = amplitud_fft_posZ / longitud_fft;

    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    
    subplot(1,2,2)
    plot(f,shift_amplitud_fft_posZ)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Posicion en Z')
    
end