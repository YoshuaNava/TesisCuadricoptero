syms pitch roll yaw;
Rx(pitch) = [1, 0, 0; 0, cos(pitch), -sin(pitch); 0, sin(pitch), cos(pitch)];
Ry(roll) = [cos(roll), 0, sin(roll); 0, 1, 0; -sin(roll), 0, cos(roll)];
Rz(yaw) = [cos(yaw), -sin(yaw), 0; sin(yaw), cos(yaw), 0; 0, 0, 1];

R(yaw,roll,pitch) = Rz(yaw) * Ry(roll) * Rx(pitch);

syms u v w;
Vw(u,v,w) = [u; v; w];
dxdt(yaw,roll,pitch,u,v,w) = R(yaw,roll,pitch)*Vw(u,v,w)

T(yaw,roll,pitch) = [1, tan(roll)*sin(pitch), tan(roll)*cos(pitch); 0, cos(pitch), -sin(pitch); 0, sec(roll)*sin(pitch), sec(roll)*cos(pitch)];
syms p q r;
Omega(p,q,r) = [p; q; r];
dYPRdt(yaw,roll,pitch,p,q,r) = T(yaw,roll,pitch)*Omega(p,q,r)

syms Fx Fy Fz g mass;
G(g) = [0; 0; g];
F(Fx,Fy,Fz) = [Fx; Fy; Fz];
Aw(Fx,Fy,Fz,p,mass,q,r,u,v,w) = (1/mass)*F(Fx,Fy,Fz) + R(yaw,roll,pitch)*G(g) - cross(Omega(p,q,r),Vw(u,v,w))


syms Ixx Iyy Izz Tx Ty Tz;
I(Ixx,Iyy,Izz) = [Ixx, 0, 0; 0, Iyy, 0; 0, 0, Izz];
Torques(Tx,Ty,Tz) = [Tx; Ty; Tz];
dOmegadt(Ixx,Iyy,Izz,Tx,Ty,Tz,p,q,r) = inv(I(Ixx,Iyy,Izz))*Torques(Tx,Ty,Tz) - cross(inv(I(Ixx,Iyy,Izz))*Omega(p,q,r), I(Ixx,Iyy,Izz)*Omega(p,q,r))
x(p,q,r,pitch,roll,yaw) = [p; q; r; pitch; roll; yaw]


