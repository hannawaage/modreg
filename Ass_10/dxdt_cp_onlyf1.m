function dxdt = dxdt_cp_onlyf1(t,x)
a = pi/4;
g = 9.81;

theta = x(1);
dtheta = x(2);
x_p = x(3);
dx = x(4);

if theta <= pi/2 && theta >= -pi/2
    f = -2*(1+cos(a))/(sin(a))*g;
else
    f = -2*(1+cos(a))/(sin(a))*g; %f1
end
ddtheta = (1/(1-0.5*cos(theta)^2))*(-0.5*cos(theta)*sin(theta)*dtheta^2 - (0.5*f*cos(theta)-g*sin(theta)));
ddx = (1/cos(theta))*(g*sin(theta) - ddtheta);

dxdt = [dtheta; ddtheta; dx; ddx];



