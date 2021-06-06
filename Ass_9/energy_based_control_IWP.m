%% Find T, x0
clear;
close;
syms q1 dq1;
final_time = 3;
tspan = [0 final_time];
x0 = [pi/6; 0];

[t, x] = ode45(@(t, x) dxdt_iwp(t, x), tspan, x0);

[pks,locs] = findpeaks(x(:, 1));

time_last_peak = t(locs(end));
num_peaks = length(pks);
T = time_last_peak/num_peaks;

q10 = x(1:locs(1), 1);
dq10 = x(1:locs(1), 2);
x0 = [q10; dq10];

% plot(t, x(:, 1));
% legend('q1');
% grid;

%% Find range of parameters 

close;

tspan = [0 T];
x0 = [pi/6; 0; 0];
overview = [];
for k1 = -5:5
    for k2  = -5:5
        for k3  = -5:5
            ks = [k1; k2; k3];
            [t_int, int] = ode45(@(t_int, int) integral_sim(t_int, int, ks), tspan, x0);
            result = [k1, k2, k3, int(end)];
            overview = [overview; result];
        end
    end
end

accepted_ks = [];
rejected_ks = [];
for i = 1:length(overview)
    if overview(i, 4) < 0
        ks = [overview(i, 1), overview(i, 2), overview(i, 3)];
        accepted_ks = [accepted_ks; ks];
    else
        ks = [overview(i, 1), overview(i, 2), overview(i, 3)];
        rejected_ks = [rejected_ks; ks];
    end
end

scatter3(accepted_ks(:, 1), accepted_ks(:, 2), accepted_ks(:, 3), 'red');
title('Plot of integral values. Red shows negative integrals, which indicates Zhukovsky stable system. Green is positive integral, i. e. unstable system');
hold on
scatter3(rejected_ks(:, 1), rejected_ks(:, 2), rejected_ks(:, 3), 'green');
xlabel('k1');
ylabel('k2');
zlabel('k3');



