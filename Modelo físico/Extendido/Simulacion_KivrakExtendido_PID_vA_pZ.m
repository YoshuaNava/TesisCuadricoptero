ControllabilityObservability_KivrakExtendido()

tF = 20;
dt = 0.01;
t = 0:dt:tF;
numIteraciones = tF/dt;

kP_vA = [1.0 1.0 0.5];
kI_vA = [0 0 0];
kD_vA = [0 0 0];
vA_deseada = [0 0 0];
error_vA = [0 0 0];
errorPrevio_vA = [0 0 0];
integral_vA = [0 0 0];
derivada_vA = [0 0 0];
pid_vA = [0 0 0];

kP_pZ = 0.01;
kI_pZ = 0;
kD_pZ = 0;
pZ_deseada = 10;
error_pZ = 0;
errorPrevio_pZ = 0;
integral_pZ = 0;
derivada_pZ = 0;
pid_pZ = 0;

u = zeros(numEntradasControl, numIteraciones+1);
x_dot = zeros(numEstados, numIteraciones+1);
x = zeros(numEstados, numIteraciones+1);
x(1:numEstados,1) = [10 15 5 0 0 0 0 0 0 1];  %p, q, r, pitch, roll, yaw


for i = 1:numIteraciones
    vPitch = x(1, i);
    vRoll = x(2, i);
    vYaw = x(3, i);
    error_vA(1) = vA_deseada(1) - vPitch;
    error_vA(2) = vA_deseada(2) - vRoll;
    error_vA(3) = vA_deseada(3) - vYaw;
    integral_vA = integral_vA + error_vA;
    derivada = error_vA - errorPrevio_vA;
    errorPrevio_vA = error_vA;
    pid_vA(1) = kP_vA(1)*error_vA(1) + kI_vA(1)*integral_vA(1) + kD_vA(1)*derivada_vA(1);
    pid_vA(2) = kP_vA(2)*error_vA(2) + kI_vA(2)*integral_vA(2) + kD_vA(2)*derivada_vA(2);
    pid_vA(3) = kP_vA(3)*error_vA(3) + kI_vA(3)*integral_vA(3) + kD_vA(3)*derivada_vA(3);
    
    error_pZ = -(pZ_deseada - x(10,i));
    integral_pZ = integral_pZ + error_pZ;
    derivada_pZ = error_pZ - errorPrevio_pZ;
    errorPrevio_pZ = error_pZ;
    pid_pZ = kP_pZ*error_pZ + kI_pZ*integral_pZ + kD_pZ*derivada_pZ;
    
    
    %pitch: u2 positivo, u4 negativo
    %roll: u1 positivo, u3 negativo
    %yaw: u2, u4 positivos; u1, u3 negativos
    u(2, i) = pid_vA(1) + pid_vA(3) + pid_pZ;
    u(4, i) = -pid_vA(1) + pid_vA(3) + pid_pZ;
    u(3, i) = -pid_vA(2) - pid_vA(3) + pid_pZ;
    u(1, i) = pid_vA(2) - pid_vA(3) + pid_pZ;

    x_dot(1:numEstados, i) = A*x(1:numEstados, i) + B*u(1:numEntradasControl, i);
    x(1:numEstados,i+1) = x(1:numEstados, i) + dt*x_dot(1:numEstados, i);
    if (x(10,i+1) < 0)
        z(10,i+1) = 0;
    end
end

figure()
plot(t,x(1:3,:))
axis([0 tF -100 100])
xlabel('Tiempo (s)')
ylabel('Velocidad angular (grados/s)')
title('Velocidades angulares')
figure()
plot(t,x(4:6,:))
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Angulo (grados)')
title('Angulos de Yaw, Pitch y Roll')
figure()
plot(t,x(7:9,:))
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Velocidad (m/s)')
title('Velocidades lineales')
figure()
plot(t,x(10,:))
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Distancia (m)')
title('Altura')
figure()
plot(t,u)
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Voltaje (V)')
title('Señales de control')