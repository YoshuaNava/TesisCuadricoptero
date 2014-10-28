Ixx = 0.0142;
Iyy = 0.0142;
Izz = 0.0071;
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

funcionIncremento(p,q,r,pitch,roll,yaw,Vm1,Vm2,Vm3,Vm4,u,v,w,z) = [dOmegadt(Vm1,Vm2,Vm3,Vm4,p,q,r); dYPRdt(yaw,roll,pitch,p,q,r); Aw(Vm1,Vm2,Vm3,Vm4,p,q,r,u,v,w); dZdt(roll,pitch,u,v,w)];
funcionIncrementoLazoAbierto(p,q,r,pitch,roll,yaw,u,v,w,z) = funcionIncremento(p,q,r,pitch,roll,yaw,0,0,0,0,u,v,w,z)

A_jacobiano_f_estado(p,q,r,pitch,roll,yaw,u,v,w,z) = jacobian(funcionIncrementoLazoAbierto(p,q,r,pitch,roll,yaw,u,v,w,z), estado(p,q,r,pitch,roll,yaw,u,v,w,z));

p_0 = 0;
q_0 = 0;
r_0 = 0;
pitch_0 = 0;
roll_0 = 0;
yaw_0 = 0;
u_0 = 0;
v_0 = 0;
w_0 = 0;
z_0 = 1;
numEstados = 10;
numEntradasControl = 4;

dt = 0.5;
for i=-10:10
    pitch_0 = dt*i;
    roll_0 = dt*i;
    [pM,qM,rM] = meshgrid(-10:0.5:10,-10:0.5:10,-10:0.5:10);
    p_dotdot = (3*qM.*rM)/2 + 12310569/1420000000;
    q_dotdot = 74739447/2840000000 - (3*pM.*rM)/2;
    r_dotdot = 1017297/14200000;
    figure
    quiver(pM,qM,p_dotdot,q_dotdot)


    [pitchM,rollM,yawM] = meshgrid(-10:0.5:10,-10:0.5:10,-10:0.5:10);
    pitch_dot = pM + rM.*cos(pitch_0)*tan(roll_0) + qM.*sin(pitch_0)*tan(roll_0);
    roll_dot = qM.*cos(pitch_0) - rM.*sin(pitch_0);
    yaw_dot = (rM.*cos(pitch_0))/cos(roll_0) + (qM.*sin(pitch_0))/cos(roll_0);
    figure
    quiver(pitchM,rollM,pitch_dot,roll_dot)
end


A = double(A_jacobiano_f_estado(p_0, q_0, r_0, pitch_0, roll_0, yaw_0, u_0, v_0, w_0, z_0))

polos_A = eig(A)