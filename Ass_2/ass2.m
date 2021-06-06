clear
clc

syms R_a(t)
R_a(t) = [(100*cos(t) - 150*cos(2*t));
          (100*sin(t) - 150*cos(2*t));
          5*sin(t)];
      
dR_a(t) = diff(R_a, t);
abs_der(t) = (sqrt(transpose(dR_a)*dR_a));
matlabFunction(abs_der,'FILE','ode_fun');

tspan = [0 2*pi];
s_0 = 0;
[t,s] = ode45(@(t, s) ode_fun(t), tspan, s_0);

dist = s(end);

%% Task 2

V = sqrt(transpose(dR_a)*dR_a);
tau = dR_a/V;

ddR_a = diff(R_a, 2);

dV = diff(V);
n_unnorm = ddR_a - dV*tau;
norm_n = sqrt(transpose(n_unnorm)*n_unnorm);
n = simplify(n_unnorm/norm_n);
b = (cross(tau, n));
R = [tau, n, b];

%% Task 3

S = R - transpose(R);
A = formula(S);
a = [A(3, 2); A(1, 3); A(2, 1)];
abs_a = sqrt(transpose(a)*a);

k = a/abs_a;

%% Task 4

dtau = diff(tau);
dn = diff(n);
db = diff(b);

w_rel = 0.5*(cross(tau, dtau) + cross(n, dn) + cross(b, db));






