function AnalisisFrecuencia(nombreArchivoCSV, frecuenciaMuestreo)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    velocidadPitch = datosArchivo(:,5);
    velocidadRoll = datosArchivo(:,6);
    velocidadYaw = datosArchivo(:,7);
    fft_velocidadPitch = fft(velocidadPitch, numeroDatos);
    fft_velocidadRoll = fft(velocidadRoll, numeroDatos);
    fft_velocidadYaw = fft(velocidadYaw, numeroDatos);
    
    frecuencia = (0 : numeroDatos - 1) * ( frecuenciaMuestreo / numeroDatos);
    potencias_velocidadPitch = fft_velocidadPitch.*conj(fft_velocidadPitch)/numeroDatos;
    potencias_velocidadRoll = fft_velocidadRoll.*conj(fft_velocidadRoll)/numeroDatos;
    potencias_velocidadYaw = fft_velocidadYaw.*conj(fft_velocidadYaw)/numeroDatos;
    figure()
    plot(frecuencia, potencias_velocidadPitch)
    xlabel('Frequency (Hz)')
    ylabel('Power')
    title('{\bf Periodogram Pitch}')
    figure()
    plot(frecuencia, potencias_velocidadRoll)
    xlabel('Frequency (Hz)')
    ylabel('Power')
    title('{\bf Periodogram Roll}')
    figure()
    plot(frecuencia, potencias_velocidadYaw)
    xlabel('Frequency (Hz)')
    ylabel('Power')
    title('{\bf Periodogram Yaw}')

    
    
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
    %maximoValor = max([max(amplitud_fft_velocidadPitch), max(amplitud_fft_velocidadRoll), max(amplitud_fft_velocidadYaw)])
    maximoValor = 2
    
    f=(-longitud_fft/2 : (longitud_fft/2-1)) * frecuenciaMuestreo/longitud_fft;
    figure()
    plot(f, shift_amplitud_fft_velocidadPitch)
    %xlim([0 max(f)])
    ylim([0 maximoValor])
    title('Pitch')
    figure()
    plot(f, shift_amplitud_fft_velocidadRoll)
    %xlim([0 max(f)])
    ylim([0 maximoValor])
    title('Roll')
    %figure()
    %plot(f, amplitud_fft_velocidadYaw)
    %ylim([0 maximoValor])
    %title('Yaw')
    
%     figure()
%     plot(frecuencia, abs(fft_velocidadPitch))
%     xlabel('Frequency (Hz)')
%     ylabel('Amplitude')
%     title('{\bf Periodogram Pitch}')
%     figure()
%     plot(frecuencia, abs(fft_velocidadRoll))
%     xlabel('Frequency (Hz)')
%     ylabel('Amplitude')
%     title('{\bf Periodogram Roll}')
%     figure()
%     plot(frecuencia, abs(fft_velocidadYaw))
%     xlabel('Frequency (Hz)')
%     ylabel('Amplitude')
%     title('{\bf Periodogram Yaw}')

end