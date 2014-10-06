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
    plot(frecuencia, potencias_velocidadPitch)
    plot(frecuencia, potencias_velocidadRoll)
    plot(frecuencia, potencias_velocidadYaw)
    xlabel('Frequency (Hz)')
    ylabel('Power')
    title('{\bf Periodogram}')

end