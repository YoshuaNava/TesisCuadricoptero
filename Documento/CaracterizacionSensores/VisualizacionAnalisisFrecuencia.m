function [f, pitch, roll, yaw] = VisualizacionAnalisisFrecuencia(nombreArchivoCSV, frecuenciaMuestreo)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    velocidadPitch = datosArchivo(:,5);
    velocidadRoll = datosArchivo(:,6);
    velocidadYaw = datosArchivo(:,7);
     
%      [b,a] = butter(10,40/(frecuenciaMuestreo/2),'low');
%      fvtool(b,a)
%      velocidadPitch = filter(b,a, velocidadPitch);
%      velocidadRoll = filter(b,a, velocidadRoll);
%     [b,a] = butter(10,40/(frecuenciaMuestreo/2),'high');
%     velocidadPitch = filter(b,a, velocidadPitch);
%     velocidadRoll = filter(b,a, velocidadRoll);
%     a = 1;
%     b = [1/8 1/8 1/8 1/8 1/8 1/8 1/8 1/8];
%     velocidadPitch = filter(b,a, velocidadPitch);
%     velocidadRoll = filter(b,a, velocidadRoll);
    figure('position', [0, 0, 9999, 9999],'name','Velocidades Angulares')
    subplot(1,3,1)
    plot(velocidadPitch)
    title('Pitch')
    if (abs(min(velocidadPitch)) > max(velocidadPitch))
        ylim([min(velocidadPitch) abs(min(velocidadPitch))])
    else
        ylim([-max(velocidadPitch) max(velocidadPitch)])
    end
    xlim([0 length(velocidadPitch)])
    figure(1)
    subplot(1,3,2)
    plot(velocidadRoll)
    title('Roll')
    if (abs(min(velocidadRoll)) > max(velocidadRoll))
        ylim([min(velocidadRoll) abs(min(velocidadRoll))])
    else
        ylim([-max(velocidadRoll) max(velocidadRoll)])
    end
    xlim([0 length(velocidadRoll)])
    figure(1)
    subplot(1,3,3)
    plot(velocidadYaw)
    title('Yaw')
    xlim([0 length(velocidadYaw)])
    if (abs(min(velocidadYaw)) > max(velocidadYaw))
        ylim([min(velocidadYaw) abs(min(velocidadYaw))])
    else
        ylim([-max(velocidadYaw) max(velocidadYaw)])
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
    %maximoValor = max([max(shift_amplitud_fft_velocidadPitch), max(shift_amplitud_fft_velocidadRoll), max(shift_amplitud_fft_velocidadYaw)]);
    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    figure('position',[0,0,9999,9999],'name','Frecuencia de Velocidades Angulares')
    subplot(1,3,1)
    plot(f,shift_amplitud_fft_velocidadPitch)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Pitch')
    subplot(1,3,2)
    plot(f,shift_amplitud_fft_velocidadRoll)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    title('Roll')
    subplot(1,3,3)
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

%     frecuencia = (0 : numeroDatos - 1) * ( frecuenciaMuestreo / numeroDatos);
%     potencias_velocidadPitch = shift_amplitud_fft_velocidadPitch.*conj(shift_amplitud_fft_velocidadPitch)/numeroDatos;
%     potencias_velocidadRoll = shift_amplitud_fft_velocidadRoll.*conj(shift_amplitud_fft_velocidadRoll)/numeroDatos;
%     potencias_velocidadYaw = shift_amplitud_fft_velocidadYaw.*conj(shift_amplitud_fft_velocidadYaw)/numeroDatos;
%     maximoValor = max([max(potencias_velocidadPitch), max(potencias_velocidadRoll), max(potencias_velocidadYaw)]);
%     figure('name',nombreArchivoCSV)
%     plot(f, potencias_velocidadPitch)
%     xlabel('Frequency (Hz)')
%     ylabel('Power')
%     title('{\bf Periodogram Pitch}')
%     xlim([0 frecuenciaMuestreo/2])
%     if(maximoValor > 0)
%         ylim([0 maximoValor])
%     else
%         ylim([0 1])
%     end
%     figure('name',nombreArchivoCSV)
%     plot(f, potencias_velocidadRoll)
%     xlabel('Frequency (Hz)')
%     ylabel('Power')
%     title('{\bf Periodogram Roll}')
%     xlim([0 frecuenciaMuestreo/2])
%     if(maximoValor > 0)
%         ylim([0 maximoValor])
%     else
%         ylim([0 1])
%     end    
%     figure('name',nombreArchivoCSV)
%     plot(frecuencia, potencias_velocidadYaw)
%     xlabel('Frequency (Hz)')
%     ylabel('Power')
%     title('{\bf Periodogram Yaw}')
%     xlim([0 frecuenciaMuestreo/2])
%     if(maximoValor > 0)
%         ylim([0 maximoValor])
%     else
%         ylim([0 1])
%     end

end