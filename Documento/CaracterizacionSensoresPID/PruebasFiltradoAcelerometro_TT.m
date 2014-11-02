function VisualizacionAnalisisFrecuencia(nombreArchivoCSV, frecuenciaMuestreo)
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


    
    
    NFFT_senal = 2^nextpow2(numeroDatos);
    f = frecuenciaMuestreo/2*linspace(0,1,NFFT_senal/2+1);
    
    
    
    
        
    figure_aceleraciones_angulares = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales')
    subplot(2,3,1)
    plot(aceleracionPitch(1:30),'.')
    title('Pitch')
    if (abs(min(aceleracionPitch)) > max(aceleracionPitch))
        ylim([min(aceleracionPitch) abs(min(aceleracionPitch))])
    else
        ylim([-max(aceleracionPitch) 1+max(aceleracionPitch)])
    end
    xlim([0 length(aceleracionPitch)])
    subplot(2,3,2)
    plot(aceleracionRoll(1:30),'.')
    title('Roll')
    if (abs(min(aceleracionRoll)) > max(aceleracionRoll))
        ylim([min(aceleracionRoll) abs(min(aceleracionRoll))])
    else
        ylim([-max(aceleracionRoll) 1+max(aceleracionRoll)])
    end
    xlim([0 length(aceleracionRoll)])
    subplot(2,3,3)
    plot(aceleracionYaw(1:30),'.')
    title('Yaw')
    xlim([0 length(aceleracionYaw)])
    if (abs(min(aceleracionYaw)) > max(aceleracionYaw))
        ylim([min(aceleracionYaw) abs(min(aceleracionYaw))])
    else
        ylim([-max(aceleracionYaw) 1+max(aceleracionYaw)])
    end
    
    fft_aceleracionPitch = fft(aceleracionPitch(1:30), NFFT_senal)/numeroDatos;
    fft_aceleracionRoll = fft(aceleracionRoll(1:30), NFFT_senal)/numeroDatos;
    fft_aceleracionYaw = fft(aceleracionYaw(1:30), NFFT_senal)/numeroDatos;
    
    subplot(2,3,4)
    plot(f,2*abs(fft_aceleracionPitch(1:NFFT_senal/2+1)),'.')
    title('Pitch')
    subplot(2,3,5)
    plot(f,2*abs(fft_aceleracionRoll(1:NFFT_senal/2+1)),'.')
    title('Roll')
    subplot(2,3,6)
    plot(f,2*abs(fft_aceleracionYaw(1:NFFT_senal/2+1)),'.')
    title('Yaw')
    

    
    media_aceleracionPitch = mean(aceleracionPitch)
    media_aceleracionRoll = mean(aceleracionRoll)
    media_aceleracionYaw = mean(aceleracionYaw)
    std_aceleracionPitch = std(aceleracionPitch)
    std_aceleracionRoll = std(aceleracionRoll)
    std_aceleracionYaw = std(aceleracionYaw)
    
    
    
%     
%     figure_aceleraciones_angulares_filtradas = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales filtradas')
%     subplot(2,3,1)
%     plot(aceleracionPitch_filtrada)
%     title('Pitch filtrada')
%     if (abs(min(aceleracionPitch_filtrada)) > max(aceleracionPitch_filtrada))
%         ylim([min(aceleracionPitch_filtrada) abs(min(aceleracionPitch_filtrada))])
%     else
%         ylim([-max(aceleracionPitch_filtrada) 1+max(aceleracionPitch_filtrada)])
%     end
%     xlim([0 length(aceleracionPitch_filtrada)])
%     subplot(2,3,2)
%     plot(aceleracionRoll_filtrada)
%     title('Roll filtrada')
%     if (abs(min(aceleracionRoll_filtrada)) > max(aceleracionRoll_filtrada))
%         ylim([min(aceleracionRoll_filtrada) abs(min(aceleracionRoll_filtrada))])
%     else
%         ylim([-max(aceleracionRoll_filtrada) 1+max(aceleracionRoll_filtrada)])
%     end
%     xlim([0 length(aceleracionRoll_filtrada)])
%     subplot(2,3,3)
%     plot(aceleracionYaw_filtrada)
%     title('Yaw filtrada')
%     xlim([0 length(aceleracionYaw_filtrada)])
%     if (abs(min(aceleracionYaw_filtrada)) > max(aceleracionYaw_filtrada))
%         ylim([min(aceleracionYaw_filtrada) abs(min(aceleracionYaw_filtrada))])
%     else
%         ylim([-max(aceleracionYaw_filtrada) 1+max(aceleracionYaw_filtrada)])
%     end
%     
%     fft_aceleracionPitch_filtrada = fft(aceleracionPitch_filtrada, NFFT_senal)/numeroDatos;
%     fft_aceleracionRoll_filtrada = fft(aceleracionRoll_filtrada, NFFT_senal)/numeroDatos;
%     fft_aceleracionYaw_filtrada = fft(aceleracionYaw_filtrada, NFFT_senal)/numeroDatos;
%     
%     subplot(2,3,4)
%     plot(f,2*abs(fft_aceleracionPitch_filtrada(1:NFFT_senal/2+1)))
%     title('Pitch filtrada')
%     subplot(2,3,5)
%     plot(f,2*abs(fft_aceleracionRoll_filtrada(1:NFFT_senal/2+1)))
%     title('Roll filtrada')
%     subplot(2,3,6)
%     plot(f,2*abs(fft_aceleracionYaw_filtrada(1:NFFT_senal/2+1)))
%     title('Yaw filtrada')
    
    
    
    
    
    [b,a] = butter(10,10/(frecuenciaMuestreo/2),'low');
    aceleracionPitch = filter(b,a, aceleracionPitch);
    aceleracionRoll = filter(b,a, aceleracionRoll);
    aceleracionYaw = filter(b,a, aceleracionYaw);
    figure_aceleraciones_angulares = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales filtro pasa-bajos 10Hz')
    subplot(2,3,1)
    plot(aceleracionPitch)
    title('Pitch')
    if (abs(min(aceleracionPitch)) > max(aceleracionPitch))
        ylim([min(aceleracionPitch) abs(min(aceleracionPitch))])
    else
        ylim([-max(aceleracionPitch) 1+max(aceleracionPitch)])
    end
    xlim([0 length(aceleracionPitch)])
    subplot(2,3,2)
    plot(aceleracionRoll)
    title('Roll')
    if (abs(min(aceleracionRoll)) > max(aceleracionRoll))
        ylim([min(aceleracionRoll) abs(min(aceleracionRoll))])
    else
        ylim([-max(aceleracionRoll) 1+max(aceleracionRoll)])
    end
    xlim([0 length(aceleracionRoll)])
    subplot(2,3,3)
    plot(aceleracionYaw)
    title('Yaw')
    xlim([0 length(aceleracionYaw)])
    if (abs(min(aceleracionYaw)) > max(aceleracionYaw))
        ylim([min(aceleracionYaw) abs(min(aceleracionYaw))])
    else
        ylim([-max(aceleracionYaw) 1+max(aceleracionYaw)])
    end
    fft_aceleracionPitch = fft(aceleracionPitch, NFFT_senal)/numeroDatos;
    fft_aceleracionRoll = fft(aceleracionRoll, NFFT_senal)/numeroDatos;
    fft_aceleracionYaw = fft(aceleracionYaw, NFFT_senal)/numeroDatos;
    subplot(2,3,4)
    plot(f,2*abs(fft_aceleracionPitch(1:NFFT_senal/2+1)))
    title('Pitch')
    subplot(2,3,5)
    plot(f,2*abs(fft_aceleracionRoll(1:NFFT_senal/2+1)))
    title('Roll')
    subplot(2,3,6)
    plot(f,2*abs(fft_aceleracionYaw(1:NFFT_senal/2+1)))
    title('Yaw')
    
    
%     [b,a] = butter(10,10/(frecuenciaMuestreo/2),'high');
%     aceleracionPitch = filter(b,a, aceleracionPitch);
%     aceleracionRoll = filter(b,a, aceleracionRoll);
%     aceleracionYaw = filter(b,a, aceleracionYaw);
%     figure_aceleraciones_angulares = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales filtro pasa altos 50Hz')
%     subplot(2,3,1)
%     plot(aceleracionPitch)
%     title('Pitch')
%     if (abs(min(aceleracionPitch)) > max(aceleracionPitch))
%         ylim([min(aceleracionPitch) abs(min(aceleracionPitch))])
%     else
%         ylim([-max(aceleracionPitch) 1+max(aceleracionPitch)])
%     end
%     xlim([0 length(aceleracionPitch)])
%     subplot(2,3,2)
%     plot(aceleracionRoll)
%     title('Roll')
%     if (abs(min(aceleracionRoll)) > max(aceleracionRoll))
%         ylim([min(aceleracionRoll) abs(min(aceleracionRoll))])
%     else
%         ylim([-max(aceleracionRoll) 1+max(aceleracionRoll)])
%     end
%     xlim([0 length(aceleracionRoll)])
%     subplot(2,3,3)
%     plot(aceleracionYaw)
%     title('Yaw')
%     xlim([0 length(aceleracionYaw)])
%     if (abs(min(aceleracionYaw)) > max(aceleracionYaw))
%         ylim([min(aceleracionYaw) abs(min(aceleracionYaw))])
%     else
%         ylim([-max(aceleracionYaw) 1+max(aceleracionYaw)])
%     end
%     fft_aceleracionPitch = fft(aceleracionPitch, NFFT_senal)/numeroDatos;
%     fft_aceleracionRoll = fft(aceleracionRoll, NFFT_senal)/numeroDatos;
%     fft_aceleracionYaw = fft(aceleracionYaw, NFFT_senal)/numeroDatos;    
%     subplot(2,3,4)
%     plot(f,2*abs(fft_aceleracionPitch(1:NFFT_senal/2+1)))
%     title('Pitch')
%     subplot(2,3,5)
%     plot(f,2*abs(fft_aceleracionRoll(1:NFFT_senal/2+1)))
%     title('Roll')
%     subplot(2,3,6)
%     plot(f,2*abs(fft_aceleracionYaw(1:NFFT_senal/2+1)))
%     title('Yaw')
    
%     a = 1;
%     b = [1/8 1/8 1/8 1/8 1/8 1/8 1/8 1/8];
%     aceleracionPitch = filter(b,a, aceleracionPitch);
%     aceleracionRoll = filter(b,a, aceleracionRoll);
%     aceleracionYaw = filter(b,a, aceleracionYaw);
%     figure_aceleraciones_angulares = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales filtro mediana')
%     subplot(2,3,1)
%     plot(aceleracionPitch)
%     title('Pitch')
%     if (abs(min(aceleracionPitch)) > max(aceleracionPitch))
%         ylim([min(aceleracionPitch) abs(min(aceleracionPitch))])
%     else
%         ylim([-max(aceleracionPitch) 1+max(aceleracionPitch)])
%     end
%     xlim([0 length(aceleracionPitch)])
%     subplot(2,3,2)
%     plot(aceleracionRoll)
%     title('Roll')
%     if (abs(min(aceleracionRoll)) > max(aceleracionRoll))
%         ylim([min(aceleracionRoll) abs(min(aceleracionRoll))])
%     else
%         ylim([-max(aceleracionRoll) 1+max(aceleracionRoll)])
%     end
%     xlim([0 length(aceleracionRoll)])
%     subplot(2,3,3)
%     plot(aceleracionYaw)
%     title('Yaw')
%     xlim([0 length(aceleracionYaw)])
%     if (abs(min(aceleracionYaw)) > max(aceleracionYaw))
%         ylim([min(aceleracionYaw) abs(min(aceleracionYaw))])
%     else
%         ylim([-max(aceleracionYaw) 1+max(aceleracionYaw)])
%     end
%     fft_aceleracionPitch = fft(aceleracionPitch, NFFT_senal)/numeroDatos;
%     fft_aceleracionRoll = fft(aceleracionRoll, NFFT_senal)/numeroDatos;
%     fft_aceleracionYaw = fft(aceleracionYaw, NFFT_senal)/numeroDatos;
%     subplot(2,3,4)
%     plot(f,2*abs(fft_aceleracionPitch(1:NFFT_senal/2+1)))
%     title('Pitch')
%     subplot(2,3,5)
%     plot(f,2*abs(fft_aceleracionRoll(1:NFFT_senal/2+1)))
%     title('Roll')
%     subplot(2,3,6)
%     plot(f,2*abs(fft_aceleracionYaw(1:NFFT_senal/2+1)))
%     title('Yaw')


    p_pitch = 0.6721;
    q_pitch = 0;
    r_pitch = 50;
    k_pitch = 4.9086e-04;
    aceleracionPitch_KF = [];
    aceleracionPitch_KF(1) = 0;
    
    p_roll = 0.6319;
    q_roll = 0;
    r_roll = 50;
    k_roll = 4.8881e-04;
    aceleracionRoll_KF = [];
    aceleracionRoll_KF(1) = 0;

    p_yaw = 0.9676;
    q_yaw = 0.1;
    r_yaw = 50;
    k_yaw = 0;
    aceleracionYaw_KF = [];
    aceleracionYaw_KF(1) = 0;
    for i=1:numeroDatos
       p_pitch = p_pitch + q_pitch;
       k_pitch = p_pitch/(p_pitch + r_pitch);
       aceleracionPitch_KF(i+1) = aceleracionPitch_KF(i) + k_pitch*(aceleracionPitch(i) - aceleracionPitch_KF(i));
       p_pitch = (1-k_pitch)*p_pitch;
       
       p_roll = p_roll + q_roll;
       k_roll = p_roll/(p_roll + r_roll);
       aceleracionRoll_KF(i+1) = aceleracionRoll_KF(i) + k_roll*(aceleracionRoll(i) - aceleracionRoll_KF(i));
       p_roll = (1-k_roll)*p_roll;

       p_yaw = p_yaw + q_yaw;
       k_yaw = p_yaw/(p_yaw + r_yaw);
       aceleracionYaw_KF(i+1) = aceleracionYaw_KF(i) + k_yaw*(aceleracionYaw(i) - aceleracionYaw_KF(i));
       p_yaw = (1-k_yaw)*p_yaw;
    end
    
    aceleracionPitch = aceleracionPitch_KF;
    aceleracionRoll = aceleracionRoll_KF;
    aceleracionYaw = aceleracionYaw_KF;
    figure_aceleraciones_angulares = figure('position', [0, 0, 9999, 9999],'name','Aceleraciones lineales con filtro de Kalman')
    subplot(2,3,1)
    plot(aceleracionPitch)
    title('Pitch')
    if (abs(min(aceleracionPitch)) > max(aceleracionPitch))
        ylim([min(aceleracionPitch) abs(min(aceleracionPitch))])
    else
        ylim([-max(aceleracionPitch) 1+max(aceleracionPitch)])
    end
    xlim([0 length(aceleracionPitch)])
    subplot(2,3,2)
    plot(aceleracionRoll)
    title('Roll')
    if (abs(min(aceleracionRoll)) > max(aceleracionRoll))
        ylim([min(aceleracionRoll) abs(min(aceleracionRoll))])
    else
        ylim([-max(aceleracionRoll) 1+max(aceleracionRoll)])
    end
    xlim([0 length(aceleracionRoll)])
    subplot(2,3,3)
    plot(aceleracionYaw)
    title('Yaw')
    xlim([0 length(aceleracionYaw)])
    if (abs(min(aceleracionYaw)) > max(aceleracionYaw))
        ylim([min(aceleracionYaw) abs(min(aceleracionYaw))])
    else
        ylim([-max(aceleracionYaw) 1+max(aceleracionYaw)])
    end
    fft_aceleracionPitch = fft(aceleracionPitch, NFFT_senal)/numeroDatos;
    fft_aceleracionRoll = fft(aceleracionRoll, NFFT_senal)/numeroDatos;
    fft_aceleracionYaw = fft(aceleracionYaw, NFFT_senal)/numeroDatos;
    subplot(2,3,4)
    plot(f,2*abs(fft_aceleracionPitch(1:NFFT_senal/2+1)))
    title('Pitch')
    subplot(2,3,5)
    plot(f,2*abs(fft_aceleracionRoll(1:NFFT_senal/2+1)))
    title('Roll')
    subplot(2,3,6)
    plot(f,2*abs(fft_aceleracionYaw(1:NFFT_senal/2+1)))
    title('Yaw')

end