ControllabilityObservability_Kivrak()

tF = 20;
dt = 0.01;
t = 0:dt:tF;
numIteraciones = tF/dt;
numEstados = 6;
numEntradasControl = 4;

kP_vA = [1.0 1.0 0.5];
kI_vA = [0 0 0];
kD_vA = [0 0 0];
vA_deseada = [0 0 0];
error_vA = [0 0 0];
errorPrevio_vA = [0 0 0];
integral_vA = [0 0 0];
derivada_vA = [0 0 0];
pid_vA = [0 0 0];

u = zeros(numEntradasControl, numIteraciones);
x_dot = zeros(numEstados, numIteraciones);
x = zeros(numEstados, numIteraciones);
x(1:numEstados,1) = [10 15 5 0 0 0];  %p, q, r, pitch, roll, yaw

for i = 1:numIteraciones
%     vPitch = x(1, i) + x(2, i)*(tan(x(5, i))*sin(x(4, i))) + x(3, i)*(tan(x(5, i))*cos(x(4, i)));
%     vRoll = x(2, i)*(cos(x(4, i))) - x(3, i)*(sin(x(4, i)));
%     vYaw = x(2, i)*(sec(x(5, i))*sin(x(4, i))) + x(3, i)*(sec(x(5, i))*cos(x(4, i)));
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
    %pitch: u2 positivo, u4 negativo
    %roll: u1 positivo, u3 negativo
    %yaw: u2, u4 positivos; u1, u3 negativos
    u(2, i) = pid_vA(1) + pid_vA(3);
    u(4, i) = -pid_vA(1) + pid_vA(3);
    u(3, i) = -pid_vA(2) - pid_vA(3);
    u(1, i) = pid_vA(2) - pid_vA(3);
    x_dot(1:numEstados, i) = A*x(1:numEstados, i) + B*u(1:numEntradasControl, i);
    x(1:numEstados,i+1) = x(1:numEstados, i) + dt*x_dot(1:numEstados, i);
end

figure()
plot(t,x(1:3,:))
axis([0 tF -20 20])
title('Velocidades angulares')
figure()
plot(t,x(4:6,:))
axis([0 tF -20 20])
title('Angulos')