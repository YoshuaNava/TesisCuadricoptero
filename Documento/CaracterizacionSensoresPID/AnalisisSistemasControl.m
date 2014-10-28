function AnalisisSistemasControl(nombreArchivoCSV)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    anguloYaw = datosArchivo(:,2);
    anguloPitch = datosArchivo(:,3);
    anguloRoll = datosArchivo(:,4);
    velocidadYaw = datosArchivo(:,5);
    velocidadPitch = datosArchivo(:,6);
    velocidadRoll = datosArchivo(:,7);
    
    figure()
    plot(velocidadYaw);
    figure()
    plot(velocidadPitch);
    figure()
    plot(velocidadRoll);
end