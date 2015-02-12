function AnalisisSistemasControl(nombreArchivoCSV)
    datosArchivo = csvread(nombreArchivoCSV, 1, 0);
    numeroDatos = size(datosArchivo,1);
    anguloPitch = datosArchivo(:,2);
    anguloRoll = datosArchivo(:,3);
    anguloYaw = datosArchivo(:,4);
    velocidadPitch = datosArchivo(:,5);
    velocidadRoll = datosArchivo(:,6);
    velocidadYaw = datosArchivo(1000:1500,7);
    
    num_datos_recogidos = size(datosArchivo,1);
    
    x = 0:0.1:num_datos_recogidos;
    y = 0*x;
    
    
    
    
    figure('name','Posicion angular en Yaw')
    plot(anguloYaw);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('Angulo (grados)')
    xlim([0 500])
    figure('name','Posicion angular en Pitch')
    plot(anguloPitch);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('Angulo (grados)')
    xlim([0 num_datos_recogidos])
    figure('name','Posicion angular en Roll')
    plot(anguloRoll);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('Angulo (grados)')
    xlim([0 num_datos_recogidos])
    figure('name','Velocidad angular en Yaw')
    plot(velocidadYaw);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('V. angular (grados/s)')
    xlim([0 500])
    figure('name','Velocidad angular en Pitch')
    plot(velocidadPitch);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('V. angular (grados/s)')
    xlim([0 num_datos_recogidos])
    figure('name','Velocidad angular en Roll')
    plot(velocidadRoll);
    hold;
    plot(x,y,'k');
    xlabel('Tiempo (s)')
    ylabel('V. angular (grados/s)')
    xlim([0 num_datos_recogidos])
end