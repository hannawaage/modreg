function int = integral_sim(t,x, ks)

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


k1 = ks(1);
k2 = ks(2);
k3 = ks(3);

der_int = -dq1*(k1*dq1 + k2*dq1^2 + k3*dq1^3);
int = [dq1; ddq1; der_int];