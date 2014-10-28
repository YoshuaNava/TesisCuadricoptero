function [f, pitch, roll, yaw] = VisualizacionAnalisisFrecuencia(nombreArchivoCSV, frecuenciaMuestreo)
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
    
    
    
    
    
    
    
    
    
    
    
    figure_velocidades_angulares_filtradas = figure('position', [0, 0, 9999, 9999],'name','Velocidades angulares filtradas')
    subplot(2,3,1)
    plot(velocidadPitch_filtrada)
    title('Pitch filtrada')
    if (abs(min(velocidadPitch_filtrada)) > max(velocidadPitch_filtrada))
        ylim([min(velocidadPitch_filtrada) abs(min(velocidadPitch_filtrada))])
    else
        ylim([-max(velocidadPitch_filtrada) max(velocidadPitch_filtrada)])
    end
    xlim([0 length(velocidadPitch_filtrada)])
    subplot(2,3,2)
    plot(velocidadRoll_filtrada)
    title('Roll filtrada')
    if (abs(min(velocidadRoll_filtrada)) > max(velocidadRoll_filtrada))
        ylim([min(velocidadRoll_filtrada) abs(min(velocidadRoll_filtrada))])
    else
        ylim([-max(velocidadRoll_filtrada) max(velocidadRoll_filtrada)])
    end
    xlim([0 length(velocidadRoll_filtrada)])
    subplot(2,3,3)
    plot(velocidadYaw_filtrada)
    title('Yaw filtrada')
    xlim([0 length(velocidadYaw_filtrada)])
    if (abs(min(velocidadYaw_filtrada)) > max(velocidadYaw_filtrada))
        ylim([min(velocidadYaw_filtrada) abs(min(velocidadYaw_filtrada))])
    else
        ylim([-max(velocidadYaw_filtrada) max(velocidadYaw_filtrada)])
    end
    
    %lol
    
    fft_velocidadPitch_filtrada = fft(velocidadPitch_filtrada, numeroDatos);
    fft_velocidadRoll_filtrada = fft(velocidadRoll_filtrada, numeroDatos);
    fft_velocidadYaw_filtrada = fft(velocidadYaw_filtrada, numeroDatos);
    
    fft_velocidadPitch_filtrada = fftshift(fft_velocidadPitch_filtrada, numeroDatos);
    fft_velocidadRoll_filtrada = fftshift(fft_velocidadRoll_filtrada, numeroDatos);
    fft_velocidadYaw_filtrada = fftshift(fft_velocidadYaw_filtrada, numeroDatos);
    amplitud_fft_velocidadPitch_filtrada = abs(fft_velocidadPitch_filtrada);
    amplitud_fft_velocidadRoll_filtrada = abs(fft_velocidadRoll_filtrada);
    amplitud_fft_velocidadYaw_filtrada = abs(fft_velocidadYaw_filtrada);
    longitud_fft = length(amplitud_fft_velocidadPitch_filtrada);
    shift_amplitud_fft_velocidadPitch_filtrada = amplitud_fft_velocidadPitch_filtrada / longitud_fft;
    shift_amplitud_fft_velocidadRoll_filtrada = amplitud_fft_velocidadRoll_filtrada / longitud_fft;
    shift_amplitud_fft_velocidadYaw_filtrada = amplitud_fft_velocidadYaw_filtrada / longitud_fft;
    maximoValor = max([max(shift_amplitud_fft_velocidadPitch_filtrada(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_velocidadRoll_filtrada(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_velocidadYaw_filtrada(longitud_fft/2:longitud_fft))]);

    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    
    subplot(2,3,4)
    plot(f,shift_amplitud_fft_velocidadPitch_filtrada)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Pitch filtrada')
    subplot(2,3,5)
    plot(f,shift_amplitud_fft_velocidadRoll_filtrada)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Roll filtrada')
    subplot(2,3,6)
    plot(f,shift_amplitud_fft_velocidadYaw_filtrada)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Yaw filtrada')
    
    Pitch_filtrada = shift_amplitud_fft_velocidadPitch_filtrada;
    Roll_filtrada = shift_amplitud_fft_velocidadRoll_filtrada;
    Yaw_filtrada = shift_amplitud_fft_velocidadYaw_filtrada;
    
    
    
    
    
    
    
        
    figure_aceleraciones_angulares = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales')
    subplot(2,3,1)
    plot(aceleracionPitch)
    title('Pitch')
    if (abs(min(aceleracionPitch)) > max(aceleracionPitch))
        ylim([min(aceleracionPitch) abs(min(aceleracionPitch))])
    else
        ylim([-max(aceleracionPitch) max(aceleracionPitch)])
    end
    xlim([0 length(aceleracionPitch)])
    subplot(2,3,2)
    plot(aceleracionRoll)
    title('Roll')
    if (abs(min(aceleracionRoll)) > max(aceleracionRoll))
        ylim([min(aceleracionRoll) abs(min(aceleracionRoll))])
    else
        ylim([-max(aceleracionRoll) max(aceleracionRoll)])
    end
    xlim([0 length(aceleracionRoll)])
    subplot(2,3,3)
    plot(aceleracionYaw)
    title('Yaw')
    xlim([0 length(aceleracionYaw)])
    if (abs(min(aceleracionYaw)) > max(aceleracionYaw))
        ylim([min(aceleracionYaw) abs(min(aceleracionYaw))])
    else
        ylim([-max(aceleracionYaw) max(aceleracionYaw)])
    end
    
    %lol
    
    fft_aceleracionPitch = fft(aceleracionPitch, numeroDatos);
    fft_aceleracionRoll = fft(aceleracionRoll, numeroDatos);
    fft_aceleracionYaw = fft(aceleracionYaw, numeroDatos);
    
    fft_aceleracionPitch = fftshift(fft_aceleracionPitch, numeroDatos);
    fft_aceleracionRoll = fftshift(fft_aceleracionRoll, numeroDatos);
    fft_aceleracionYaw = fftshift(fft_aceleracionYaw, numeroDatos);
    amplitud_fft_aceleracionPitch = abs(fft_aceleracionPitch);
    amplitud_fft_aceleracionRoll = abs(fft_aceleracionRoll);
    amplitud_fft_aceleracionYaw = abs(fft_aceleracionYaw);
    longitud_fft = length(amplitud_fft_aceleracionPitch);
    shift_amplitud_fft_aceleracionPitch = amplitud_fft_aceleracionPitch / longitud_fft;
    shift_amplitud_fft_aceleracionRoll = amplitud_fft_aceleracionRoll / longitud_fft;
    shift_amplitud_fft_aceleracionYaw = amplitud_fft_aceleracionYaw / longitud_fft;
    maximoValor = max([max(shift_amplitud_fft_aceleracionPitch(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_aceleracionRoll(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_aceleracionYaw(longitud_fft/2:longitud_fft))]);
    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    
    subplot(2,3,4)
    plot(f,shift_amplitud_fft_aceleracionPitch)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Pitch')
    subplot(2,3,5)
    plot(f,shift_amplitud_fft_aceleracionRoll)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Roll')
    subplot(2,3,6)
    plot(f,shift_amplitud_fft_aceleracionYaw)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Yaw')
    
    pitch = shift_amplitud_fft_aceleracionPitch;
    roll = shift_amplitud_fft_aceleracionRoll;
    yaw = shift_amplitud_fft_aceleracionYaw; 

    
    
    
    
    
    
    figure_aceleraciones_angulares_filtradas = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales filtradas')
    subplot(2,3,1)
    plot(aceleracionPitch_filtrada)
    title('Pitch filtrada')
    if (abs(min(aceleracionPitch_filtrada)) > max(aceleracionPitch_filtrada))
        ylim([min(aceleracionPitch_filtrada) abs(min(aceleracionPitch_filtrada))])
    else
        ylim([-max(aceleracionPitch_filtrada) max(aceleracionPitch_filtrada)])
    end
    xlim([0 length(aceleracionPitch_filtrada)])
    subplot(2,3,2)
    plot(aceleracionRoll_filtrada)
    title('Roll filtrada')
    if (abs(min(aceleracionRoll_filtrada)) > max(aceleracionRoll_filtrada))
        ylim([min(aceleracionRoll_filtrada) abs(min(aceleracionRoll_filtrada))])
    else
        ylim([-max(aceleracionRoll_filtrada) max(aceleracionRoll_filtrada)])
    end
    xlim([0 length(aceleracionRoll_filtrada)])
    subplot(2,3,3)
    plot(aceleracionYaw_filtrada)
    title('Yaw filtrada')
    xlim([0 length(aceleracionYaw_filtrada)])
    if (abs(min(aceleracionYaw_filtrada)) > max(aceleracionYaw_filtrada))
        ylim([min(aceleracionYaw_filtrada) abs(min(aceleracionYaw_filtrada))])
    else
        ylim([-max(aceleracionYaw_filtrada) max(aceleracionYaw_filtrada)])
    end
    
    %lol
    
    fft_aceleracionPitch_filtrada = fft(aceleracionPitch_filtrada, numeroDatos);
    fft_aceleracionRoll_filtrada = fft(aceleracionRoll_filtrada, numeroDatos);
    fft_aceleracionYaw_filtrada = fft(aceleracionYaw_filtrada, numeroDatos);
    
    fft_aceleracionPitch_filtrada = fftshift(fft_aceleracionPitch_filtrada, numeroDatos);
    fft_aceleracionRoll_filtrada = fftshift(fft_aceleracionRoll_filtrada, numeroDatos);
    fft_aceleracionYaw_filtrada = fftshift(fft_aceleracionYaw_filtrada, numeroDatos);
    amplitud_fft_aceleracionPitch_filtrada = abs(fft_aceleracionPitch_filtrada);
    amplitud_fft_aceleracionRoll_filtrada = abs(fft_aceleracionRoll_filtrada);
    amplitud_fft_aceleracionYaw_filtrada = abs(fft_aceleracionYaw_filtrada);
    longitud_fft = length(amplitud_fft_aceleracionPitch_filtrada);
    shift_amplitud_fft_aceleracionPitch_filtrada = amplitud_fft_aceleracionPitch_filtrada / longitud_fft;
    shift_amplitud_fft_aceleracionRoll_filtrada = amplitud_fft_aceleracionRoll_filtrada / longitud_fft;
    shift_amplitud_fft_aceleracionYaw_filtrada = amplitud_fft_aceleracionYaw_filtrada / longitud_fft;
    maximoValor = max([max(shift_amplitud_fft_aceleracionPitch_filtrada(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_aceleracionRoll_filtrada(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_aceleracionYaw_filtrada(longitud_fft/2:longitud_fft))]);

    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    
    subplot(2,3,4)
    plot(f,shift_amplitud_fft_aceleracionPitch_filtrada)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Pitch filtrada')
    subplot(2,3,5)
    plot(f,shift_amplitud_fft_aceleracionRoll_filtrada)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Roll filtrada')
    subplot(2,3,6)
    plot(f,shift_amplitud_fft_aceleracionYaw_filtrada)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Yaw filtrada')
    
    Pitch_filtrada = shift_amplitud_fft_aceleracionPitch_filtrada;
    Roll_filtrada = shift_amplitud_fft_aceleracionRoll_filtrada;
    Yaw_filtrada = shift_amplitud_fft_aceleracionYaw_filtrada;
    
    
    
    
    
    
    figure_aceleraciones_angulares_filtradas = figure('position', [0, 0, 9999, 9999],'name','Posicion y velocidad en Z (Altura)')
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
    
    %lol
    
    fft_posZ = fft(posZ, numeroDatos);
    fft_posZ_filtrada = fft(posZ_filtrada, numeroDatos);
    fft_velZ = fft(velZ, numeroDatos);
    
    fft_posZ = fftshift(fft_posZ, numeroDatos);
    fft_posZ_filtrada = fftshift(fft_posZ_filtrada, numeroDatos);
    fft_velZ = fftshift(fft_velZ, numeroDatos);
    amplitud_fft_posZ = abs(fft_posZ);
    amplitud_fft_posZ_filtrada = abs(fft_posZ_filtrada);
    amplitud_fft_velZ = abs(fft_velZ);
    longitud_fft = length(amplitud_fft_posZ);
    shift_amplitud_fft_posZ = amplitud_fft_posZ / longitud_fft;
    shift_amplitud_fft_posZ_filtrada = amplitud_fft_posZ_filtrada / longitud_fft;
    shift_amplitud_fft_velZ = amplitud_fft_velZ / longitud_fft;
    maximoValor = max([max(shift_amplitud_fft_posZ(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_posZ_filtrada(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_velZ(longitud_fft/2:longitud_fft))]);

    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    
    subplot(2,3,4)
    plot(f,shift_amplitud_fft_posZ)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Posicion en Z')
    subplot(2,3,5)
    plot(f,shift_amplitud_fft_posZ_filtrada)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Posicion en Z filtrada')
    subplot(2,3,6)
    plot(f,shift_amplitud_fft_velZ)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Velocidad en Z')    
    
end