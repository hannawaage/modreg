clear
clc

syms rho phi theta;
syms drho dphi dtheta;
syms ddrho ddphi ddtheta;
syms r(rho, phi, theta);

r = [rho*sin(theta)*cos(phi);
     rho*sin(theta)*sin(phi);
     rho*cos(theta)];
     
e_1 = diff(r, rho);
e_2 = diff(r, phi);
e_3 = diff(r, theta);

n_1 = e_1*drho;
no_1 = transpose(n_1)*n_1;

n_2 = e_2*dphi;
no_2 = transpose(n_2)*n_2;

n_3 = e_3*dtheta;
no_3 = transpose(n_3)*n_3;

twoK = (no_1 + no_2 + no_3);
K = 0.5*simplify(twoK);

ddr_1 = ddrho - diff(K, rho);
ddr_1_n = simplify(ddr_1/(transpose(e_1)*e_1));

ddr_2 = ddphi*rho^2*sin(theta)^2 + 2*dphi*rho*drho*sin(theta)^2 + 2*dphi*rho^2*cos(theta)*sin(theta)*dtheta;
ddr_2_n = simplify(ddr_2/(transpose(e_2)*e_2));

ddr_3 = ddtheta*rho^2 + 2*dtheta*rho*drho - diff(K, theta); 
ddr_3_n = simplify(ddr_3/(transpose(e_3)*e_3));

ddr = ddr_1_n*e_1 + ddr_2_n*e_2 + ddr_3_n*e_3;
simplify(ddr)


%% Task 3
clear
clc

% Find dr 

syms tau(t);

e_1 = [sin(2*tau)*cos(3*tau);
       sin(2*tau)*sin(3*tau);
       cos(2*tau)];
   
e_2 = -tau*[sin(2*tau)*sin(3*tau);
       sin(2*tau)*cos(3*tau);
       0];
e_3 = tau*cos(2*tau)*[cos(3*tau);
       sin(3*tau);
       -sin(2*tau)];
   
% e = simplify((e_1 + 3*e_2 + 2*e_3));
% dr = cos(t)*tau*e;
syms dtau(t);

dtau(t) = cos(t)*tau;
syms drho(t) dphi(t) dtheta(t);

drho(t) = dtau;
dphi(t) = 3*dtau;
dtheta(t) = 2*dtau;

dr = e_1*drho + e_2*dphi + e_3*dtheta;

% Find ddr

syms rho(t) phi(t) theta(t);

rho(t) = tau;
phi(t) = 3*tau;
theta(t) = 2*tau;

syms ddrho(t) ddphi(t) ddtheta(t);

ddrho(t) = -sin(t)*tau + cos(t)^2*tau;
ddphi(t) = 3*ddrho;
ddtheta(t) = 4*ddrho;

ddr = (ddrho - rho*(dtheta^2 + dphi^2*sin(theta)^2))*e_1 + (ddphi + 2*drho/rho*dphi + 2*dphi*cos(theta)/sin(theta)*dtheta)*e_2 + (ddtheta + 2*dtheta*drho/rho - dphi^2*cos(theta)*sin(theta))*e_3;
simplify(ddr)

cross_prod = simplify(cross(dr, ddr));
%curve = simplify(norm(cross_prod)/(norm(dr)^3))
curve = simplify(sqrt((transpose(cross_prod)*cross_prod))/(sqrt(transpose(dr)*dr)^3));

%% Find distances traveled
close;
clc;

% Find distance from 0 to 1

tspan = [0 1];
tau_0 = 1;
r_0 = [1*sin(2)*cos(3);
     1*sin(2)*sin(3);
     1*cos(2);
     tau_0];
 
[t, r_t] = ode45(@(t, r_t) drdt(t, r_t), tspan, r_0);

r_t = r_t(:, 1:3);
plot3(r_t(:, 1), r_t(:, 2), r_t(:, 3));
axis equal
xlabel('x(t)')
ylabel('y(t)')
zlabel('z(t)')

dist_01 = norm(r_t(1, :) - r_t(end, :))

%%
% Find distance from 2 to 3

% Simulate r at t = 2

close;

tspan = [0 2];
tau_0 = 1;
r_0 = [1*sin(2)*cos(3);
     1*sin(2)*sin(3);
     1*cos(2);
     tau_0];
 
[t, r_t] = ode45(@(t, r_t) drdt(t, r_t), tspan, r_0);

tspan = [2 3];
r_0 = r_t(end, :);

[t, r_t] = ode45(@(t, r_t) drdt(t, r_t), tspan, r_0);

r_t = r_t(:, 1:3);
plot3(r_t(:, 1), r_t(:, 2), r_t(:, 3));
axis equal
xlabel('x(t)')
ylabel('y(t)')
zlabel('z(t)')

dist_23 = norm(r_t(1, :) - r_t(end, :))




