%%%%%   Parametros del cuadricoptero   %%%%%
masaBateriaPequena = 0.0265;
masaBateriaGrande = 0.090;
masaBaseAnime = 0.0075;
masaMotor = 0.051;
masaUltrasonido = 0.009;
masaChasisCircuitos = 0.482;
masaTotal = 0.6;
masaCentral = 0.23;
longitudAspa = 0.31;
longitudEje =  0.47;
alturaMotor = 0.095;
diametroMotor = 0.025;
diametroEje = 0.005;
alturaCajaCentral = 0.1;
anchuraCajaCentral = 0.09;
radioMotor = diametroMotor/2;

%%MATRIZ DE INERCIA%%
    %%PITCH%%
        %%MOTORES SOBRE EL EJE(para un motor)%%
        inerciaPitch(1) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2);
        %%MOTORES EN EJE OPUESTO (para un motor)%%
        inerciaPitch(2) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaPitch(3) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (alturaCajaCentral^2+anchuraCajaCentral^2);
        %%TOTAL INERCIA PITCH%%
        inercia(1,1)= 2*inerciaPitch(1)+2*inerciaPitch(2) + inerciaPitch(3);
    %%ROLL%%
        %%MOTORES SOBRE EL EJE(para un motor)%%
        inerciaRoll(1) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2);
        %%MOTORES EN EJE OPUESTO (para un motor)%%
        inerciaRoll(2) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaRoll(3) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (alturaCajaCentral^2+anchuraCajaCentral^2);
        %%TOTAL INERCIA ROLL%%
        inercia(2,2)= 2*inerciaRoll(1)+2*inerciaRoll(2) + inerciaRoll(3);
     %%YAW%%
        %%PARA CADA MOTOR%%
        inerciaYaw(1) = 1/12*(masaMotor)*((3*(radioMotor/2))^2+alturaMotor^2)+(masaMotor*longitudEje);
        %%CAJA CENTRAL%%
        inerciaYaw(2) = 1/12 * (masaCentral+masaBaseAnime+masaChasisCircuitos) * (anchuraCajaCentral^2+anchuraCajaCentral^2);
        
        inercia(3,3) = 4 * inerciaYaw(1) + inerciaYaw(2);
        
        
Ixx = inercia(1,1)
Iyy = inercia(2,2)
Izz = inercia(3,3)
% Ixx = 0.0142;
% Iyy = 0.0142;
% Izz = 0.0071;
longitudEje =  0.47;
L = longitudEje/2;
masa = 0.6;
gravedad = 9.81;
c = 0.1; %Consultar referencia. Que es eso?


syms Vm1 Vm2 Vm3 Vm4;
Fm1(Vm1) = 9.81*(22.4935*Vm1 - 9.732)/1000;
Fm2(Vm2) = 9.81*(22.4926*Vm2 - 9.5271)/1000;
Fm3(Vm3) = 9.81*(22.6127*Vm3 - 9.8941)/1000;
Fm4(Vm4) = 9.81*(22.6184*Vm4 - 9.5805)/1000;


syms pitch roll yaw;
Rx(pitch) = [1, 0, 0; 0, cos(pitch), -sin(pitch); 0, sin(pitch), cos(pitch)];
Ry(roll) = [cos(roll), 0, sin(roll); 0, 1, 0; -sin(roll), 0, cos(roll)];
Rz(yaw) = [cos(yaw), -sin(yaw), 0; sin(yaw), cos(yaw), 0; 0, 0, 1];

R(yaw,roll,pitch) = Rz(yaw) * Ry(roll) * Rx(pitch);

syms u v w;
Vw(u,v,w) = [u; v; w];
dZdt(roll,pitch,u,v,w) = -sin(roll)*u + sin(pitch)*cos(roll)*v + cos(roll)*cos(pitch)*w;

T(yaw,roll,pitch) = [1, tan(roll)*sin(pitch), tan(roll)*cos(pitch); 0, cos(pitch), -sin(pitch); 0, sec(roll)*sin(pitch), sec(roll)*cos(pitch)];
syms p q r;
Omega(p,q,r) = [p; q; r];
dYPRdt(yaw,roll,pitch,p,q,r) = T(yaw,roll,pitch)*Omega(p,q,r); % Derivada de yaw, roll y pitch, en funcion de las velocidades angulares p, q y r

G = [0; 0; gravedad];
F(Vm1,Vm2,Vm3,Vm4) = [0; 0; -Fm1(Vm1) - Fm2(Vm2) - Fm3(Vm3) - Fm4(Vm4)];
Aw(Vm1,Vm2,Vm3,Vm4,p,q,r,u,v,w) = (1/masa)*F(Vm1,Vm2,Vm3,Vm4) + R(yaw,roll,pitch)*G - cross(Omega(p,q,r),Vw(u,v,w)); %Aceleracion del cuerpo en funcion de: 
                                                                                                                     %Las velocidades angulares p, q y r
                                                                                                                     %El voltaje de los motores Vm1, Vm2, Vm3 y Vm4
                                                                                                                     %Las velocidades lineales del cuerpo u, v y w

I = [Ixx, 0, 0; 0, Iyy, 0; 0, 0, Izz];
Torques(Vm1,Vm2,Vm3,Vm4) = [L*(Fm2(Vm2) - Fm4(Vm4)); L*(Fm1(Vm1) - Fm3(Vm3)); c*(-Fm1(Vm1) + Fm2(Vm2) - Fm3(Vm3) + Fm4(Vm4))];
dOmegadt(Vm1,Vm2,Vm3,Vm4,p,q,r) = inv(I)*Torques(Vm1,Vm2,Vm3,Vm4) - cross(inv(I)*Omega(p,q,r), I*Omega(p,q,r)); %Aceleraciones angulares en funcion de:
                                                                                                                %Las velocidades angulares p, q y r
                                                                                                                %El voltaje de los motores Vm1, Vm2, Vm3 y Vm4
syms z;
estado(p,q,r,pitch,roll,yaw,u,v,w,z) = [p; q; r; pitch; roll; yaw; u; v; w; z];
senalControl(Vm1,Vm2,Vm3,Vm4) = [Vm1; Vm2; Vm3; Vm4];

funcionIncremento(p,q,r,pitch,roll,yaw,Vm1,Vm2,Vm3,Vm4,u,v,w,z) = [dOmegadt(Vm1,Vm2,Vm3,Vm4,p,q,r); dYPRdt(yaw,roll,pitch,p,q,r); Aw(Vm1,Vm2,Vm3,Vm4,p,q,r,u,v,w); dZdt(roll,pitch,u,v,w)]

A_jacobiano_f_estado(p,q,r,pitch,roll,yaw,u,v,w,z) = jacobian(funcionIncremento(p,q,r,pitch,roll,yaw,Vm1,Vm2,Vm3,Vm4,u,v,w,z), estado(p,q,r,pitch,roll,yaw,u,v,w,z))
B_jacobiano_f_senalControl(Vm1,Vm2,Vm3,Vm4) = jacobian(funcionIncremento(p,q,r,pitch,roll,yaw,Vm1,Vm2,Vm3,Vm4,u,v,w,z), senalControl(Vm1,Vm2,Vm3,Vm4))


p_0 = 0;
q_0 = 0;
r_0 = 0;
pitch_0 = 0;
roll_0 = 0;
yaw_0 = 0;
u_0 = 0;
v_0 = 0;
w_0 = 0;
x_0 = 0;
y_0 = 0;
z_0 = 1;
numEstados = 10;
numEntradasControl = 4;


A = double(A_jacobiano_f_estado(p_0, q_0, r_0, pitch_0, roll_0, yaw_0, u_0, v_0, w_0, z_0))
B = double(B_jacobiano_f_senalControl(0,0,0,0))
C = eye(numEstados);
C(7,7) = 0;
C(8,8) = 0;
C
D = zeros(numEstados,numEntradasControl)

dt = 0.0001;


%Respuesta en lazo abierto a condiciones iniciales distintas de cero.
t = 0:0.01:2;
u = [zeros(size(t)); zeros(size(t)); zeros(size(t)); zeros(size(t))];
%u = [ones(size(t)); ones(size(t)); ones(size(t)); ones(size(t))];
x0 = [10; 15; 10; 10; 10; 10; 10; 10; 10; 10]; %Condiciones iniciales en formato [vPitch, vRoll, vYaw, aPitch, aRoll, aYaw, vX, vY, vZ].

sys = ss(A,B,C,D);

[y,t,x] = lsim(sys,u,t,x0);
plot(t,y)
axis([0 2 -20 20])
title('Respuesta en lazo abierto a condiciones iniciales distintas de cero.')
xlabel('Tiempo (s)')
ylabel('Posicion del cuadricoptero (m)')

matrizObservabilidad = obsv(sys);
estadosNoObservables = length(A) - rank(matrizObservabilidad)

matrizControlabilidad = ctrb(sys);
estadosNoControlables = length(A) - rank(matrizControlabilidad)

polos_A = eig(A)


tF = 20;
t = 0:dt:tF;
numIteraciones = round(tF/dt);
voltajeMaximoMotores = 11.1;
fE_vA = 0.01;
fE_pA = 0.02;
fE_vZ = 0.04;
fE_pZ = 0.05;


kP_pA = [1.0 1.0 1.0];
kI_pA = [0 0 0];
kD_pA = [0 0 0];
pA_deseada = [10 5 16];
error_pA = [0 0 0];
errorPrevio_pA = [0 0 0];
integral_pA = [0 0 0];
derivada_pA = [0 0 0];
pid_pA = [0 0 0];


kP_vA = [5.0 5.0 5.0];
kI_vA = [0 0 0];
kD_vA = [0 0 0];
vA_deseada = [0 0 0];
error_vA = [0 0 0];
errorPrevio_vA = [0 0 0];
integral_vA = [0 0 0];
derivada_vA = [0 0 0];
pid_vA = [0 0 0];

kP_pZ = 1;
kI_pZ = 0;
kD_pZ = 0;
pZ_deseada = 10;
error_pZ(1) = 0;
errorPrevio_pZ = 0;
integral_pZ = 0;
derivada_pZ = 0;
pid_pZ = 0;

kP_vZ = 3;
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
x(1:numEstados,1) = [10 15 5 0 0 0 0 0 0 1];  %p, q, r, pitch, roll, yaw, u, v, w
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
        error_vA(1) = pid_pA(1) - vPitch;
        error_vA(2) = pid_pA(2) - vRoll;
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
subplot(2,2,1)
plot(t,x(1:3,:))
axis([0 tF -100 100])
xlabel('Tiempo (s)')
ylabel('Velocidad angular (grados/s)')
title('Velocidades angulares en Yaw, Pitch y Roll')
legend('Pitch','Roll','Yaw');
%figure()
subplot(2,2,2)
plot(t,x(4:6,:))
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Angulo (grados)')
title('Angulos de Yaw, Pitch y Roll')
legend('Pitch','Roll','Yaw');
%figure()
subplot(2,2,3)
plot(t,x(9,:))
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Velocidad (m/s)')
title('Velocidad lineal en Z')
legend('VelZ');
%figure()
subplot(2,2,4)
plot(t,x(10,:))
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Distancia (m)')
title('Altura (Z)')
legend('PosZ');
figure()
plot(t,u)
axis([0 tF -20 20])
xlabel('Tiempo (s)')
ylabel('Voltaje (V)')
title('Senales de control')