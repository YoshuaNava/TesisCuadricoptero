function [f, X, Y, Z] = AcelerometroAF(nombreArchivoCSV, frecuenciaMuestreo)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    maximoValorEnvio = 90;
    escala = 90;
    aceleracionY = datosArchivo(:,8) * (escala/maximoValorEnvio);
    aceleracionX = datosArchivo(:,9) * (escala/maximoValorEnvio);
    aceleracionZ = datosArchivo(:,10) * (escala/maximoValorEnvio);
     
%      [b,a] = butter(10,40/(frecuenciaMuestreo/2),'low');
%      fvtool(b,a)
%      aceleracionX = filter(b,a, aceleracionX);
%      aceleracionY = filter(b,a, aceleracionY);
%     [b,a] = butter(10,40/(frecuenciaMuestreo/2),'high');
%     aceleracionX = filter(b,a, aceleracionX);
%     aceleracionY = filter(b,a, aceleracionY);
%     a = 1;
%     b = [1/8 1/8 1/8 1/8 1/8 1/8 1/8 1/8];
%     aceleracionX = filter(b,a, aceleracionX);
%     aceleracionY = filter(b,a, aceleracionY);
    figure()
    plot(aceleracionX)
    mediaAceleracionX = mean(aceleracionX)
    stdAceleracionX = std(aceleracionX)
    ylim([-escala escala])
    xlabel('Time (s)')
    ylabel('Acceleration (g)')
    title('Acceleration in X')
    grid()
    figure()
    plot(aceleracionY)
    mediaAceleracionY = mean(aceleracionY)
    stdAceleracionY = std(aceleracionY)
    ylim([-escala escala])
    xlabel('Time (s)')
    ylabel('Acceleration (g)')
    title('Acceleration in Y')
    grid()
    figure()
    plot(aceleracionZ)
    mediaAceleracionZ = mean(aceleracionZ)
    stdAceleracionZ = std(aceleracionZ)
    ylim([-escala escala])
    xlabel('Time (s)')
    ylabel('Acceleration (g)')
    title('Acceleration in Z')
    grid()
    %lol
    
    fft_aceleracionX = fft(aceleracionX, numeroDatos);
    fft_aceleracionY = fft(aceleracionY, numeroDatos);
    fft_aceleracionZ = fft(aceleracionZ, numeroDatos);
    
    fft_aceleracionX = fftshift(fft_aceleracionX, numeroDatos);
    fft_aceleracionY = fftshift(fft_aceleracionY, numeroDatos);
    fft_aceleracionZ = fftshift(fft_aceleracionZ, numeroDatos);
    amplitud_fft_aceleracionX = abs(fft_aceleracionX);
    amplitud_fft_aceleracionY = abs(fft_aceleracionY);
    amplitud_fft_aceleracionZ = abs(fft_aceleracionZ);
    longitud_fft = length(amplitud_fft_aceleracionX);
    shift_amplitud_fft_aceleracionX = amplitud_fft_aceleracionX / longitud_fft;
    shift_amplitud_fft_aceleracionY = amplitud_fft_aceleracionY / longitud_fft;
    shift_amplitud_fft_aceleracionZ = amplitud_fft_aceleracionZ / longitud_fft;
    maximoValor = max([max(shift_amplitud_fft_aceleracionX(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_aceleracionY(longitud_fft/2:longitud_fft)), max(shift_amplitud_fft_aceleracionZ(longitud_fft/2:longitud_fft))]);
    %maximoValor = max([max(shift_amplitud_fft_aceleracionX), max(shift_amplitud_fft_aceleracionY), max(shift_amplitud_fft_aceleracionZ)]);
    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    figure('name',nombreArchivoCSV)
    plot(f,shift_amplitud_fft_aceleracionX)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    xlabel('Frequency (Hz)')
    ylabel('Amplitude (g)')
    title('Periodogram X')
    grid()
    figure('name',nombreArchivoCSV)
    plot(f,shift_amplitud_fft_aceleracionY)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    xlabel('Frequency (Hz)')
    ylabel('Amplitude (g)')
    title('Periodogram Y')
    grid()
    figure('name',nombreArchivoCSV)
    plot(f,shift_amplitud_fft_aceleracionZ)
    xlim([0 frecuenciaMuestreo/2])
    if(maximoValor > 0)
        ylim([0 maximoValor])
    else
        ylim([0 1])
    end
    xlabel('Frequency (Hz)')
    ylabel('Amplitude (g)')
    title('Periodogram Z')
    grid()
    
    %X = shift_amplitud_fft_aceleracionX;
    %Y = shift_amplitud_fft_aceleracionY;
    %Z = shift_amplitud_fft_aceleracionZ; 
    f = 0;
    X = 0;
    Y = 0;
    Z = 0;
%     frecuencia = (0 : numeroDatos - 1) * ( frecuenciaMuestreo / numeroDatos);
%     potencias_aceleracionX = shift_amplitud_fft_aceleracionX.*conj(shift_amplitud_fft_aceleracionX)/numeroDatos;
%     potencias_aceleracionY = shift_amplitud_fft_aceleracionY.*conj(shift_amplitud_fft_aceleracionY)/numeroDatos;
%     potencias_aceleracionZ = shift_amplitud_fft_aceleracionZ.*conj(shift_amplitud_fft_aceleracionZ)/numeroDatos;
%     maximoValor = max([max(potencias_aceleracionX), max(potencias_aceleracionY), max(potencias_aceleracionZ)]);
%     figure('name',nombreArchivoCSV)
%     plot(f, potencias_aceleracionX)
%     xlabel('Frequency (Hz)')
%     ylabel('Power')
%     title('{\bf Periodogram X}')
%     xlim([0 frecuenciaMuestreo/2])
%     if(maximoValor > 0)
%         ylim([0 maximoValor])
%     else
%         ylim([0 1])
%     end
%     figure('name',nombreArchivoCSV)
%     plot(f, potencias_aceleracionY)
%     xlabel('Frequency (Hz)')
%     ylabel('Power')
%     title('{\bf Periodogram Y}')
%     xlim([0 frecuenciaMuestreo/2])
%     if(maximoValor > 0)
%         ylim([0 maximoValor])
%     else
%         ylim([0 1])
%     end    
%     figure('name',nombreArchivoCSV)
%     plot(frecuencia, potencias_aceleracionZ)
%     xlabel('Frequency (Hz)')
%     ylabel('Power')
%     title('{\bf Periodogram Z}')
%     xlim([0 frecuenciaMuestreo/2])
%     if(maximoValor > 0)
%         ylim([0 maximoValor])
%     else
%         ylim([0 1])
%     end

end