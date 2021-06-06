%% PD control
tspan = [0 20];
x_0 = [pi, 0];

[t, x] = ode45(@dxdt_pd, tspan, x_0);

theta_ref = pi + 0.3*sin(2*t);
dtheta_ref = (3/5)*cos(2*t);

figure(1);
sgtitle('One dof system with PD control simulated');
subplot(2, 1, 1);
plot(t,x(:,1),'-o',t,theta_ref,'-o')
title('\theta');
xlabel('Time t');
ylabel('\theta');
legend('\theta','\theta_{ref}')

subplot(2, 1, 2);
plot(t,x(:,2),'-o',t,dtheta_ref,'-o')
title('d\theta');
xlabel('Time t');
ylabel('d\theta');
legend('d\theta','d\theta_{ref}')

%% Feedback linearization
tspan = [0 20];
x_0 = [pi, 0];

[t, x] = ode45(@dxdt_fbl, tspan, x_0);

theta_ref = pi + 0.3*sin(2*t);
dtheta_ref = (3/5)*cos(2*t);

figure(1);
sgtitle('One dof system with feedback linearization control simulated');
subplot(2, 1, 1);
plot(t,x(:,1),'-o',t,theta_ref,'-o')
title('\theta');
xlabel('Time t');
ylabel('\theta');
legend('\theta','\theta_{ref}')

subplot(2, 1, 2);
plot(t,x(:,2),'-o',t,dtheta_ref,'-o')
title('d\theta');
xlabel('Time t');
ylabel('d\theta');
legend('d\theta','d\theta_{ref}')

%% Passivity based
tspan = [0 15];
x_0 = [pi, 0];

[t, x] = ode45(@dxdt_pass, tspan, x_0);

theta_ref = pi + 0.3*sin(2*t);
dtheta_ref = (3/5)*cos(2*t);

figure(1);
sgtitle('One dof system with passivity based control simulated');
subplot(2, 1, 1);
plot(t,x(:,1),'-o',t,theta_ref,'-o')
title('\theta');
xlabel('Time t');
ylabel('\theta');
legend('\theta','\theta_{ref}')

subplot(2, 1, 2);
plot(t,x(:,2),'-o',t,dtheta_ref,'-o')
title('d\theta');
xlabel('Time t');
ylabel('d\theta');
legend('d\theta','d\theta_{ref}')