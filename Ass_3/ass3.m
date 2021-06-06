% Assignment 3
%% a)

clear
clc
close

w_a = [1 0 0].';
S_a = cross2mat(w_a);

tspan = [0 3];
R_0 = eye(3);
[~, R_t] = ode45(@(t, R_t_a) ode_fun(R_t_a, S_a), tspan, R_0);

timesteps = length(R_t(:, 1));
R_t = reshape(R_t, [timesteps, 3 , 3]);

figure(1);
sgtitle('Time evolution of body frame');
e = ['e_1'; 'e_2'; 'e_3'];
for i = 1:3
    subplot(1, 3, i);
    e_t = reshape(R_t(:, :, i), [timesteps, 3]);
    plot3(e_t(:, 1), e_t(:, 2), e_t(:, 3));
    title(e(i, :));
end

% 2)

R_T_t = zeros(timesteps, 3, 3);
w_e_t = zeros(timesteps, 3);

for i = 1:timesteps
    R = reshape(R_t(i, :, :), [3,3]);
    R_T_t(i, :, :) = R.';
    w_e_t(i, :, 1) = (R.')*w_a;
end

figure(3);
sgtitle('Time evoultion of angular velocity ');
plot3(w_e_t(:, 1), w_e_t(:, 2), w_e_t(:, 3));
hold on
plot3(w_a(1), w_a(2), w_a(3))
legend('Body frame', 'World frame')



%% b)
clear;
clc;
close;

tspan = [0 3];
R_0 = eye(3);
w_0 = [1; 0; 0];
initial = [reshape(R_0, [9,1]); w_0];
[t, R_t] = ode45(@(t, R_t) ode_fun_t(t, R_t, 'b'), tspan, initial);

w_t = R_t(:, 10:12);
R_t = R_t(:, 1:9);

timesteps = length(R_t(:, 1));
R_t = reshape(R_t, [timesteps, 3 , 3]);

figure(2);
sgtitle('Time evolution of body frame');
e = ['e_1'; 'e_2'; 'e_3'];
for i = 1:3
    subplot(1, 3, i);
    e_t = reshape(R_t(:, :, i), [timesteps, 3]);
    plot3(e_t(:, 1), e_t(:, 2), e_t(:, 3));
    title(e(i, :));
end

% 2)

R_T_t = zeros(timesteps, 3, 3);
w_e_t = zeros(timesteps, 3);

for i = 1:timesteps
    R = reshape(R_t(i, :, :), [3,3]);
    R_T_t(i, :, :) = R.';
    w_e_t(i, :, 1) = (R.')*w_t(i, :).';
end

figure(3);
sgtitle('Time evoultion of angular velocity ');
plot3(w_e_t(:, 1), w_e_t(:, 2), w_e_t(:, 3))
hold on
plot3(w_t(:, 1), w_t(:, 2), w_t(:, 3));
legend('Body frame', 'World frame')

%% c)
clear;
clc;
close;

tspan = [0 3];
R_0 = eye(3);
w_0 = [1; 0; 0];
initial = [reshape(R_0, [9,1]); w_0];
[t, R_t] = ode45(@(t, R_t) ode_fun_t(t, R_t, 'c'), tspan, initial);

w_t = R_t(:, 10:12);
R_t = R_t(:, 1:9);

timesteps = length(R_t(:, 1));
R_t = reshape(R_t, [timesteps, 3 , 3]);

figure(4);
sgtitle('Time evolution of body frame');
e = ['e_1'; 'e_2'; 'e_3'];
for i = 1:3
    subplot(1, 3, i);
    e_t = reshape(R_t(:, :, i), [length(R_t(:, 1)), 3]);
    plot3(e_t(:, 1), e_t(:, 2), e_t(:, 3));
    title(e(i, :));
end

% 2)

R_T_t = zeros(timesteps, 3, 3);
w_e_t = zeros(timesteps, 3);

for i = 1:timesteps
    R = reshape(R_t(i, :, :), [3,3]);
    R_T_t(i, :, :) = R.';
    w_e_t(i, :, 1) = (R.')*w_t(i, :).';
end

figure(5);
sgtitle('Time evoultion of angular velocity ');
plot3(w_e_t(:, 1), w_e_t(:, 2), w_e_t(:, 3))
hold on
plot3(w_t(:, 1), w_t(:, 2), w_t(:, 3));
legend('Body frame', 'World frame')
