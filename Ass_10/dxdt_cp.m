function dxdt = dxdt_cp(t,x)
a = pi/4;
g = 9.81;

xT = -4.4539;
dxT = -29.1433;
T = 0.5884;

T2 = -(1/dxT)*(2 - 2*xT - 2*dxT*T);
f2 = -2*dxT/T2;

theta = x(1);
dtheta = x(2);
x_p = x(3);
dx = x(4);

if theta <= pi/2
    f = f2;
else
    f = -2*(1+cos(a))/(sin(a))*g; %f1
end

if x_p > 1
    f = -30*dx - 50*(x_p - 2);
end

ddtheta = (1/(1-0.5*cos(theta)^2))*(-0.5*cos(theta)*sin(theta)*dtheta^2 - (0.5*f*cos(theta)-g*sin(theta)));
ddx = (1/cos(theta))*(g*sin(theta) - ddtheta);

dxdt = [dtheta; ddtheta; dx; ddx];



