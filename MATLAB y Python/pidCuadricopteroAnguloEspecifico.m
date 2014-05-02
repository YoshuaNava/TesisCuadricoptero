function pidCuadricopteroAnguloEspecifico(kP,kI,kD, velocidadBase, anguloDeseado, calibrarPitch)

if ((calibrarPitch == 1) | (calibrarPitch == 0))
    clc
    s = serial('COM20');
    set(s,'DataBits',8);
    set(s,'StopBits',1);
    set(s,'BaudRate',38400);
    fopen(s);
    disp('Com Port Open')
    i = 1;
    j = 1;
    
    
    
    soloSensores = 0;
    linea = line(nan, nan);
    numDatos = 1;
    numDatosInvalidos=0;
    limiteDatos = 250;
    timeOutEnvioConstantes = 5;
    timeOutRecepcionDatos = 30;
    constantesEnviadas = 0;
    datoPitch = 0;
    datoRoll = 0;
    datosRecibidos = 0;
    rectaAnguloDeseado = 0;
    maxError = 0;
    
    errorPitch = 0;
    
    
    errorRoll = 0;
    datosEnviados = 0;
    
    tline = 'c';
    
    
    
    tic
    tiempo = toc;
    
    
    while ((tline ~= 'k') & (tiempo < timeOutEnvioConstantes))
        %disp(toc);
        disp('Enviando constantes...');
        if(soloSensores == 0)
            %Envio de datos al cuadricoptero
            fwrite(s, 'z');
            fwrite(s,kP*100);  %PWM motor izquierdo
            fwrite(s,kI*100);
            fwrite(s,kD*100);
            fwrite(s,velocidadBase);
            fwrite(s,3*anguloDeseado+90);
            fwrite(s,kP*100 + kI*100 + kD*100);
            fwrite(s,velocidadBase + 3*anguloDeseado+90);
            disp(kP*100 + kI*100 + kD*100);
            disp(velocidadBase + 3*anguloDeseado+90);
        else
            fwrite(s, 'z');
            fwrite(s,0);
            fwrite(s,0);
            fwrite(s,0);
            fwrite(s,0);
            fwrite(s,0);
            fwrite(s,0);
            fwrite(s,0);
        end
        if (s.BytesAvailable()>0)
            tline = fgetl(s);
        end
        
        tiempo = toc;
        disp(tiempo);
        disp(tline);
        
        pause(0.1);
    end
    
    
    if (tiempo < timeOutEnvioConstantes)
        ventana = figure(1);
        tic
        tiempo = toc;
        while ((numDatos < limiteDatos) & (tiempo < timeOutRecepcionDatos))
            %Recepcion de datos del cuadricoptero
            datosValidos=0;
            while ((datosValidos==0) & (tiempo < timeOutRecepcionDatos))
                tiempo = toc;
                %disp(tiempo);
                if(s.BytesAvailable() > 0)
                    tline = fgetl(s);
                end
                while (tline ~= 'k')
                    if(s.BytesAvailable() > 0)
                        tline = fgetl(s);
                    end
                end
                
                if(s.BytesAvailable() > 0)
                    copiaYaw = str2double(fgetl(s));
                else
                    copiaYaw = NaN(1);
                end
                if(s.BytesAvailable() > 0)
                    copiaPitch = str2double(fgetl(s));
                else
                    copiaPitch = NaN(1);
                end
                if(s.BytesAvailable() > 0)
                    copiaRoll = str2double(fgetl(s));
                else
                    copiaRoll = NaN(1);
                end
                if(s.BytesAvailable() > 0)
                    altura = str2double(fgetl(s));
                else
                    altura = NaN(1);
                end
                if(s.BytesAvailable() > 0)
                    sumaRecibida = str2double(fgetl(s));
                else
                    sumaRecibida = NaN(1);
                end
                
                
                %tiempoTransmision = str2double(fgetl(s));
                
                disp('k');
                disp(copiaYaw);
                disp(copiaPitch);
                disp(copiaRoll);
                disp(altura);
                disp(sumaRecibida);
                if (~isnan(copiaYaw) && ~isnan(copiaPitch)  && ~isnan(copiaRoll) && ~isnan(altura) && ~isnan(sumaRecibida))
                    sumaCalculada = copiaYaw + copiaPitch + copiaRoll + altura;
                    if (fix(sumaCalculada) == fix(sumaRecibida))
                        datosValidos=1;
                    else
                        numDatosInvalidos = numDatosInvalidos + 1;
                    end
                end
            end
            
            flushinput(s);
            
            if (tiempo < timeOutRecepcionDatos)
                roll= copiaRoll;
                pitch = copiaPitch;
                yaw = copiaYaw;
                
                
                
                clf;
                datoPitch = [datoPitch pitch];
                datoRoll = [datoRoll roll];
                rectaAnguloDeseado = [rectaAnguloDeseado anguloDeseado];
                datosRecibidos = [datosRecibidos numDatos+1];
                if(calibrarPitch == 1)
                    plot(datosRecibidos, datoPitch, datosRecibidos, rectaAnguloDeseado);
                    title('Pitch');
                else
                    plot(datosRecibidos, datoRoll, datosRecibidos, rectaAnguloDeseado);
                    title('Roll');
                end
                axis auto;
                grid on;
                xlim([0 limiteDatos]);
                ylim([-90 90]);
                drawnow;
                
                numDatos = numDatos + 1;
                
                tiempo = toc;
                % Procesado de datos del cuadricoptero
                disp('Datos recibidos de la PC (Yaw, Pitch, Roll y altura)');
                disp(yaw);
                disp(pitch);
                disp(roll);
                disp(altura);
                %disp(tiempoTransmision);
            end
            disp('Tiempo transcurrido de prueba (En segundos)');
            disp(tiempo);
        end
        
        
        flushinput(s);
        tic
        tiempo = toc;
        while ((tline ~= 's') & (tiempo < timeOutEnvioConstantes))
            disp('Apagando cuadricoptero');
            fwrite(s, 'f');
            fwrite(s,0);  %PWM motor izquierdo
            fwrite(s,0);
            fwrite(s,0);
            fwrite(s,0);
            fwrite(s,0);
            if (s.bytesAvailable() > 0)
                tline = fgetl(s);
            end
            tiempo = toc;
        end
        
        if(tline == 's')
            disp('Cuadricoptero apagado');
        end
        
        if(calibrarPitch == 1)
            clf;
            subplot(2,1,1);
            plot(datosRecibidos, datoPitch, datosRecibidos, rectaAnguloDeseado);
            title('Pitch');
            axis auto;
            grid on;
            xlim([0 limiteDatos]);
            ylim([-90 90]);
            subplot(2,1,2);
            plot(datosRecibidos, datoRoll);
            title('Roll');
            axis auto;
            grid on;
            xlim([0 limiteDatos]);
            ylim([-90 90]);
            drawnow;
        else
            clf;
            subplot(2,1,1);
            plot(datosRecibidos, datoPitch);
            title('Pitch');
            axis auto;
            grid on;
            xlim([0 limiteDatos]);
            ylim([-90 90]);
            subplot(2,1,2);
            plot(datosRecibidos, datoRoll, datosRecibidos, rectaAnguloDeseado);
            title('Roll');
            axis auto;
            grid on;
            xlim([0 limiteDatos]);
            ylim([-90 90]);
            drawnow;
        end
        
        
        disp('Media de Pitch');
        disp(mean(datoPitch));
        disp('Media de Roll');
        disp(mean(datoRoll));
        
        disp('Numero de datos invalidos=');
        disp(numDatosInvalidos);
        
        
    end
    
    fclose(s);
    delete(s);
    clear s;
    clear all;
end

end



