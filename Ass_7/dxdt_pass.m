function dxdt = dxdt_pass(t,x)

theta = x(1);
dtheta = x(2);
theta_ref = pi + 0.3*sin(2*t);
dtheta_ref = (3/5)*cos(2*t);
ddtheta_ref = -(6/5)*sin(2*t);

M = (1-0.5*cos(theta));
C = dtheta*(1+0.25*sin(theta));
G = 4*sin(theta);
e = theta-theta_ref;
de = dtheta - dtheta_ref;
lambda = 5;
r = de +lambda*e;
a = ddtheta_ref - lambda*de;
b = dtheta - r;
K = -C;
tau = M*a + C*b + G - K*r;
u = tau;
ddtheta = (1/M)*(u-dtheta^2*(1+0.25*sin(theta)) + 4*sin(theta));
dxdt = [dtheta; ddtheta];

