function dxdt = dxdt_iwp(t,x)


q1 = x(1);
q1 = q1 - pi/2;
dq1 = x(2);

l1 = 0.125;
lc1 = 0.063;
m1 = 0.02;
m2 = 0.3;
J1 = 4.7e-5;
g = 9.81;

a = m1*lc1^2 + J1 + m2*l1^2;
b = (m1*lc1 + m2*l1)*g;

ddq1 = -(b/a)*cos(q1);

dxdt = [dq1; ddq1];



