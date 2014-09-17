
p1 = -10 + 10i;
p2 = -10 - 10i;
p3 = -30;
p4 = -10 + 5i;
p5 = -10 - 5i;
p6 = -30;

K = place(A,B,[p1 p2 p3 p4 p5 p6]);
sys_cl = ss(A-B*K,B,C,D);

lsim(sys_cl,u,t,x0);
xlabel('Tiempo (s)')
ylabel('Posicion del cuadricoptero (m)')
