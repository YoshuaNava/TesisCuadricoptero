Modelo_KivrakExtendido_Param()
%Respuesta en lazo abierto a condiciones iniciales distintas de cero.
t = 0:0.01:2;
u = [zeros(size(t)); zeros(size(t)); zeros(size(t)); zeros(size(t))];
%u = [ones(size(t)); ones(size(t)); ones(size(t)); ones(size(t))];
x0 = [10; 15; 0; 0; 0; 0; 0; 0; 0; 0]; %Condiciones iniciales en formato [vPitch, vRoll, vYaw, aPitch, aRoll, aYaw, vX, vY, vZ].

sys = ss(A,B,C,D);

[y,t,x] = lsim(sys,u,t,x0);
plot(t,y)
axis([0 2 -20 20])
title('Respuesta en lazo abierto a condiciones iniciales distintas de cero.')
xlabel('Tiempo (s)')
ylabel('Posicion del cuadricoptero (m)')

%figure()
%step(A,B,C,0)