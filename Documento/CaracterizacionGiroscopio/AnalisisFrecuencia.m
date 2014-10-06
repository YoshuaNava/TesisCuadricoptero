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