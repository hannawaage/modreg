function dxdt = dxdt_fbl(vars, t,x)

d1 = vars(1);
d2 = vars(2);
gamma = vars(3);

q1 = x(1);
q2 = x(2);
dq1 = x(3);
dq2 = x(4);

L = -gamma;

q1_ref =  -pi/2 + 0.3*sin(2*t);
dq1_ref = (3/5)*cos(2*t);
ddq1_ref = -(6/5)*sin(2*t);

z1 = x(5);
z2 = x(6);
z3 = x(7);
z4 = x(8);
z = [z1; z2; z3; z4];

z1_ref =d1*q1_ref+d2*q2;
z2_ref =  d1*dq1_ref+d2*dq2;
z3_ref =  -gamma*cos(q1_ref);
z4_ref = gamma*sin(q1_ref)*dq1_ref;
z_ref = [z1_ref; z2_ref; z3_ref; z4_ref];
dz4_ref = gamma*cos(q1_ref)*dq1_ref^2+gamma*sin(q1_ref)*ddq1_ref;%-L*(cos(q1_ref)*dq1_ref^2 + sin(q1_ref*ddq1_ref));

Q = 50*eye(4);
R = 1;
A = [0 1 0 0;
     0 0 1 0;
     0 0 0 1;
     0 0 0 0];
B = [0;0;0;1];
K = 20*lqr(A, B, Q, R);
v = dz4_ref - K*(z-z_ref);
dz4 = v;

A = -L*(cos(q1)*dq1^2 + sin(q1)*(-gamma*cos(q1)*(1/(d1-d2))));
B = -L*sin(q1)*(-1/(d1-d2));
u = (v-A)/B;

ddq1 = -(1/(d1-d2))*(gamma*cos(q1) + u);
ddq2 = (1/(d1-d2))*(gamma*cos(q1) + d1*u/d2);

dxdt = [dq1; dq2; ddq1; ddq2; z2; z3; z4; dz4; u; v];



