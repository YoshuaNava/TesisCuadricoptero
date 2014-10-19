%Modelo_Kivrak_Param()
%Respuesta en lazo abierto a condiciones iniciales distintas de cero.
t = 0:0.01:2;
u = [zeros(size(t)); zeros(size(t)); zeros(size(t)); zeros(size(t))];
%u = [ones(size(t)); ones(size(t)); ones(size(t)); ones(size(t))];
x0 = [10; 15; 0; 0; 0; 0]; %Condiciones iniciales en formato [vPitch, vRoll, vYaw, aPitch, aRoll, aYaw].

sys = ss(A,B,C,D);

[y,t,x] = lsim(sys,u,t,x0);
plot(t,y)
axis([0 2 -20 20])
title('Respuesta en lazo abierto a condiciones iniciales distintas de cero.')
xlabel('Tiempo (s)')
ylabel('Posicion del cuadricoptero (m)')

%%Simualacion
%ControllabilityObservabillity_Kivrak()

tF = 10;
dt = 0.01;
t = 0:dt:tF;
numIteraciones = tF/dt;
numEstados = 6;
numEntradasControl = 4;
u = zeros(numEntradasControl, numIteraciones);
x_dot = zeros(numEstados, numIteraciones);
x = zeros(numEstados, numIteraciones);
x(1,1:numEstados) = [0 0 0 0 0 0];

for i = 1:numIteraciones
    x_dot(1:numEstados, i) = A*x(1:numEstados, i) + B*u(1:numEntradasControl, i);
    x(1:numEstados,i+1) = x(1:numEstados, i) + dt*x_dot(1:numEstados, i);
end

plot(t,x(3:6,:))
axis([0 2 -20 20])
