ControllabilityObservability_KivrakExtendido()

tF = 20;
t = 0:dt:tF;
numIteraciones = round(tF/dt);
voltajeMaximoMotores = 11.1;
fE_vA = 0.01;
fE_pA = 0.02;
fE_vZ = 0.04;
fE_pZ = 0.05;


kP_pA = [0 0 1.0];
kI_pA = [0 0 0];
kD_pA = [0 0 0];
pA_deseada = [0 0 0];
error_pA = [0 0 0];
errorPrevio_pA = [0 0 0];
integral_pA = [0 0 0];
derivada_pA = [0 0 0];
pid_pA = [0 0 0];


kP_vA = [5.0 5.0 5.0];
kI_vA = [0 0 0];
kD_vA = [0 0 0];
vA_deseada = [-10 20 0];
error_vA = [0 0 0];
errorPrevio_vA = [0 0 0];
integral_vA = [0 0 0];
derivada_vA = [0 0 0];
pid_vA = [0 0 0];

kP_pZ = 0;
kI_pZ = 0;
kD_pZ = 0;
pZ_deseada = 10;
error_pZ(1) = 0;
errorPrevio_pZ = 0;
integral_pZ = 0;
derivada_pZ = 0;
pid_pZ = 0;

kP_vZ = 0;
kI_vZ = 0;
kD_vZ = 0;
vZ_deseada = 0;
error_vZ(1) = 0;
errorPrevio_vZ = 0;
integral_vZ = 0;
derivada_vZ = 0;
pid_vZ = 0;

u = zeros(numEntradasControl, numIteraciones+1);
x_dot = zeros(numEstados, numIteraciones+1);
x = zeros(numEstados, numIteraciones+1);
x(1:numEstados,1) = [0 0 10 0 0 0 0 0 0 1];  %p, q, r, pitch, roll, yaw, u, v, w
y = zeros(numEstados, numIteraciones+1);

for i = 1:numIteraciones
    y(1:numEstados, i) = C*x(1:numEstados, i);
    vPitch = y(1, i);
    vRoll = y(2, i);
    vYaw = y(3, i);
    aPitch = y(4, i);
    aRoll = y(5, i);
    aYaw = y(6, i);
    vZ = y(9, i);
    pZ = y(10, i);
    
    if (mod(i*dt,fE_pA) == 0)
        error_pA(1) = pA_deseada(1) - aPitch;
        error_pA(2) = pA_deseada(2) - aRoll;
        error_pA(3) = pA_deseada(3) - aYaw;
        integral_pA = integral_pA + error_pA;
        derivada_pA = error_pA - errorPrevio_pA;
        errorPrevio_pA = error_pA;
        pid_pA(1) = kP_pA(1)*error_pA(1) + kI_pA(1)*integral_pA(1) + kD_pA(1)*derivada_pA(1);
        pid_pA(2) = kP_pA(2)*error_pA(2) + kI_pA(2)*integral_pA(2) + kD_pA(2)*derivada_pA(2);
        pid_pA(3) = kP_pA(3)*error_pA(3) + kI_pA(3)*integral_pA(3) + kD_pA(3)*derivada_pA(3);
    end
    if (mod(i*dt,fE_vA) == 0)
        error_vA(1) = vA_deseada(1) - vPitch;
        error_vA(2) = vA_deseada(2) - vRoll;
        error_vA(3) = pid_pA(3) - vYaw;
        integral_vA = integral_vA + error_vA;
        derivada_vA = error_vA - errorPrevio_vA;
        errorPrevio_vA = error_vA;
        pid_vA(1) = kP_vA(1)*error_vA(1) + kI_vA(1)*integral_vA(1) + kD_vA(1)*derivada_vA(1);
        pid_vA(2) = kP_vA(2)*error_vA(2) + kI_vA(2)*integral_vA(2) + kD_vA(2)*derivada_vA(2);
        pid_vA(3) = kP_vA(3)*error_vA(3) + kI_vA(3)*integral_vA(3) + kD_vA(3)*derivada_vA(3);
    end
    
    if (mod(i*dt,fE_pZ) == 0)
        error_pZ(i+1) = (pZ_deseada - pZ);
        integral_pZ = integral_pZ + error_pZ(i+1);
        derivada_pZ = error_pZ(i+1) - errorPrevio_pZ;
        errorPrevio_pZ = error_pZ(i+1);
        pid_pZ = kP_pZ*error_pZ(i+1) + kI_pZ*integral_pZ + kD_pZ*derivada_pZ;
    end
    
    if (mod(i*dt,fE_vZ) == 0)
        error_vZ(i+1) = -(pid_pZ - vZ);
        integral_vZ = integral_vZ + error_vZ(i+1);
        derivada_vZ = error_vZ(i+1) - errorPrevio_vZ;
        errorPrevio_vZ = error_vZ(i+1);
        pid_vZ = kP_vZ*error_vZ(i+1) + kI_vZ*integral_vZ + kD_vZ*derivada_vZ;
    end
    
    %pitch: u2 positivo, u4 negativo
    %roll: u1 positivo, u3 negativo
    %yaw: u2, u4 positivos; u1, u3 negativos
    u(2, i) = pid_vA(1) + pid_vA(3) + pid_vZ;
    u(4, i) = -pid_vA(1) + pid_vA(3) + pid_vZ;
    u(3, i) = -pid_vA(2) - pid_vA(3) + pid_vZ;
    u(1, i) = pid_vA(2) - pid_vA(3) + pid_vZ;
    if (u(1,i) > voltajeMaximoMotores)
        u(1,i) = voltajeMaximoMotores;
    end
    if (u(2,i) > voltajeMaximoMotores)
        u(2,i) = voltajeMaximoMotores;
    end
    if (u(3,i) > voltajeMaximoMotores)
        u(3,i) = voltajeMaximoMotores;
    end
    if (u(4,i) > voltajeMaximoMotores)
        u(4,i) = voltajeMaximoMotores;
    end
    
    x_dot(1:numEstados, i) = A*x(1:numEstados, i) + B*u(1:numEntradasControl, i);
    x(1:numEstados,i+1) = x(1:numEstados, i) + dt*x_dot(1:numEstados, i);
    if (x(10,i+1) < 0)
        x(10,i+1) = 0;
    end
end

figure()
subplot(2,1,1)
plot(t,x(1:3,:))
axis([0 tF -100 100])
xlabel('Tiempo (s)')
ylabel('Velocidad angular (grados/s)')
title('Velocidades angulares en Yaw, Pitch y Roll')
legend('Pitch','Roll','Yaw');
%figure()
subplot(2,1,2)
plot(t,x(6,:))
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Angulo (grados)')
title('Angulo de Yaw')
legend('Yaw');
figure()
plot(t,u)
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Voltaje (V)')
title('Senales de control')