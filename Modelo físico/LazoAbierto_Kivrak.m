%Respuesta en lazo abierto a condiciones iniciales distintas de cero.
t = 0:0.01:2;
u = [zeros(size(t)); zeros(size(t)); zeros(size(t)); zeros(size(t))];
x0 = [10; 10; 0; 0.1; 0; 0]; %Condiciones iniciales en formato [vPitch, vRoll, vYaw, pitch, roll, yaw].

sys = ss(A,B,C,D);

[y,t,x] = lsim(sys,u,t,x0);
plot(t,y)
axis([0 2 -5 5])
title('Respuesta en lazo abierto a condiciones iniciales distintas de cero.')
xlabel('Tiempo (s)')
ylabel('Posicion del cuadricoptero (m)')


