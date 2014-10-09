function GraficasSobrepuestas(nombreArchivoCSV, frecuenciaMuestreo)

L = size(nombreArchivoCSV);
for i=(1:L(1,1))
    disp(L(1,1))
    [f, pitch, roll, yaw] = AnalisisFrecuencia(nombreArchivoCSV(i,:), frecuenciaMuestreo);
    hold on
    figure(1)
%     figure ('name','Pich')
    plot(f,pitch)
    hold on
    figure(2)
%     figure ('name','Roll')
    plot(f,roll)
    hold on
    figure(3)
%     figure ('name','Yaw')
    plot(f,yaw)
end
end