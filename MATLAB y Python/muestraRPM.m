function muestraRPM(pwm,tiempomuestra)
clc
if (((pwm>=0) & (pwm<256)) & ((tiempomuestra>=0) & (tiempomuestra<30001)))
    s = serial('COM7','Baudrate',19200);
    
    cantidadDigitosTiempo=numel(num2str(tiempomuestra));
    digitosSumaTiempoMuestra=numel(num2str(tiempomuestra+cantidadDigitosTiempo));
    cantidadDigitosPwm = numel(num2str(pwm));
    digitosSumaPwm=numel(num2str(cantidadDigitosPwm+pwm));
    %4,1234-4,1238!4,9000-4,9004!
    mensaje = strcat(num2str(cantidadDigitosPwm),',',num2str(pwm),'-',num2str(digitosSumaPwm),',',num2str(cantidadDigitosPwm+pwm),'!');
    mensaje = strcat(mensaje,num2str(cantidadDigitosTiempo),',',num2str(tiempomuestra),'-',num2str(digitosSumaTiempoMuestra),',',num2str(digitosSumaTiempoMuestra+tiempomuestra),'!');
    disp(mensaje);
    
    numVueltas = 0;
    
    fopen(s);
    tic;
    tline='c';
    tiempo=toc;
    while((tiempo*1000 < tiempomuestra) & (tline ~= 'r'))
        fwrite(s,'a');
        fwrite(s,mensaje);
        tiempo=toc;
        disp(strcat(num2str(tiempo*1000),' mS'));
        if (s.BytesAvailable()>0)
            tline = fgetl(s);
            disp(tline);
        end
        pause(0.1);
    end
    
    tic;
    
    while((tiempo*1000 < tiempomuestra) & (tline ~= 'z'))
        tiempo=toc;
        disp(strcat(num2str(tiempo*1000),' mS'));
        if (s.BytesAvailable()>0)
            tline = fgetl(s);
            %disp(tline);
            if(~isnan(str2double(tline)))
                numVueltas = str2double(tline);
            end
        end
    end
    
    disp('Numero de vueltas=');
    disp(fix((numVueltas/4)*60000/tiempomuestra));
    
    fclose(s);
end
end
