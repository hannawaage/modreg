
%% Simulate and find T, xT and dxT
close;
clc;

tspan = [0 1.2];

x0_p = 0;
theta0 = pi;
x0 = [theta0; 0; x0_p; 0];

[t, x] = ode45(@(t, x) dxdt_cp_onlyf1(t, x), tspan, x0);

figure(1);
sgtitle('Cart pendulum manouver');
subplot(2, 1, 1);
plot(t, x(:, 1));
legend('\theta(t)');

subplot(2, 1, 2);
plot(t, x(:, 3));
legend('x(t)');

[pks,locs] = findpeaks(x(:, 1));
time_last_peak = t(locs(end));
num_peaks = length(pks);
T = time_last_peak/(2*num_peaks);

a = pi/4;
g = 9.81;
f1 = -2*(1+cos(a))/(sin(a))*g;
xT = 0.5*(0.5*f1*T^2 + 2*x0_p - sin(a));
dxT = x(end, 4);

%% Simulate complete movement
clear;
close;
clc;

tspan = [0 10];

x0_p = 0;
theta0 = pi;
x0 = [theta0; 0; x0_p; 0];

[t, x] = ode45(@(t, x) dxdt_cp(t, x), tspan, x0);
x_s = x(:, 3);
thetas = x(:, 1);

figure(2);
sgtitle('Cart pendulum manouver');
subplot(2, 1, 1);
plot(t, thetas);
hold on;
plot(t(x_s > 1), thetas(x_s > 1));
legend('\theta(t)', '\theta(t) for x > 1');
pimin = -5;
pimax = 5;
yticks((pimin:pimax) * pi);
yticklabels( string(pimin:pimax) + "\pi" )


subplot(2, 1, 2);
plot(t, x_s);
hold on;
plot(t(x_s > 1), x_s(x_s > 1));
legend('x(t)', 'x(t) > 1');


