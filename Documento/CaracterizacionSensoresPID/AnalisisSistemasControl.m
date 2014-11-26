function AnalisisSistemasControl(nombreArchivoCSV)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    anguloPitch = datosArchivo(:,2);
    anguloRoll = datosArchivo(:,3);
    anguloYaw = datosArchivo(:,4);
    velocidadPitch = datosArchivo(700:900,5);
    velocidadRoll = datosArchivo(100:300,6);
    velocidadYaw = datosArchivo(300:500,7);
    
    x = 0:0.1:200;
    y = 0*x;
    
    figure()
    plot(velocidadYaw);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('V. angular (grados/s)')
    xlim([0 200])
    figure()
    plot(velocidadPitch);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('V. angular (grados/s)')
    xlim([0 200])
    figure()
    plot(velocidadRoll);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('V. angular (grados/s)')
    xlim([0 200])
end