%% Feedback linearization

%% a)
close;
clc;

tspan = [0 20];
l1 = 0.125;
lc1 = 0.063;
m1 = 0.02;
m2 = 0.3;
J1 = 4.7e-5;
J2 = 3.2e-5;
g = 9.81;

d1 = m1*lc1^2 + J1 + m2*l1^2 + J2;
d2 = J2;
gamma = g*(m1*lc1 + m2*l1);
L = -gamma;
vars = [d1, d2, gamma];

q10 = -pi/4;
q20 = 0;
z10 = d1*q10 + d2*q20;
z30 = L*cos(q10);
z4 = 0;

x0 = [q10; q20; 0; 0; z10; 0; z30; 0; 0; 0];

[t, x] = ode45(@(t, x) dxdt_fbl(vars, t, x), tspan, x0);

q1_ref = -pi/2 + 0.3*sin(2*t);
dq1_ref = (3/5)*cos(2*t);

q1 = x(:, 1);
q2 = x(:, 2);
dq1 = x(:, 3);
dq2 = x(:, 4);
u = x(:, 9);
v = x(:, 10);


figure(1);
sgtitle('Inertia wheel pendulum system with feedback linearization control');
subplot(3, 1, 1);
plot(t,q1,'-o',t,q1_ref,'-o')
title('q1');
xlabel('Time t');
ylabel('q1');
legend('q1','q1{ref}')

subplot(3, 1, 2);
plot(t,dq1,'-o',t,dq1_ref,'-o')
title('dq1');
xlabel('Time t');
ylabel('dq1');
legend('dq1','dq1{ref}')

subplot(3, 1, 3);
plot(t,u,'-o', t, v,'-o')
title('Actuation');
xlabel('Time t');
ylabel('');
legend('u', 'v')

%% b)
close;
clc;

tspan = [0 25];
l1 = 0.125;
lc1 = 0.063;
m1 = 0.02;
m2 = 0.3;
J1 = 4.7e-5;
J2 = 3.2e-5;
g = 9.81;

d1 = m1*lc1^2 + J1 + m2*l1^2 + J2;
d2 = J2;
gamma = g*(m1*lc1 + m2*l1);
L = -gamma;
vars = [d1, d2, gamma];

q10 = pi/2;
q20 = 0;
z10 = d1*q10 + d2*q20;
z30 = L*cos(q10);
z4 = 0;

x0 = [q10; q20; 0; 0; z10; 0; z30; 0; 0; 0];

[t, x] = ode45(@(t, x) dxdt_fbl_b(vars, t, x), tspan, x0);

q1_ref = 5*pi/9 + 0.3*sin(2*t);
dq1_ref = (3/5)*cos(2*t);

q1 = x(:, 1);
q2 = x(:, 2);
dq1 = x(:, 3);
dq2 = x(:, 4);
u = x(:, 9);
v = x(:, 10);


figure(1);
sgtitle('Inertia wheel pendulum system with feedback linearization control');
subplot(3, 1, 1);
plot(t,q1,'-o',t,q1_ref,'-o')
title('q1');
xlabel('Time t');
ylabel('q1');
legend('q1','q1{ref}')

subplot(3, 1, 2);
plot(t,dq1,'-o',t,dq1_ref,'-o')
title('dq1');
xlabel('Time t');
ylabel('dq1');
legend('dq1','dq1{ref}')

subplot(3, 1, 3);
plot(t,u,'-o', t, v,'-o')
title('Actuation');
xlabel('Time t');
ylabel('');
legend('u', 'v')

% %% Testing
% 
% A = [0 1 0 0;
%      0 0 1 0;
%      0 0 0 1;
%      0 0 0 0];
% B = [0;0;0;1];
% syms k1 k2 k3 k4;
% K = [k1 k2 k3 k4];
% 
% sys = A - B*K;
% charpoly(sys)