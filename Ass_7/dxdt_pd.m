function dxdt = dxdt_pd(t,x)

theta = x(1);
dtheta = x(2);
theta_ref = pi + 0.3*sin(2*t);
dtheta_ref = (3/5)*cos(2*t);
Kp = 10;
Kd = 1;
u = -Kp*(theta-theta_ref)-Kd*(dtheta-dtheta_ref);
fac = (1-0.5*cos(theta));
ddtheta = (1/fac)*(u-dtheta^2*(1+0.25*sin(theta)) + 4*sin(theta));
dxdt = [dtheta; ddtheta];

