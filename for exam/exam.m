clear
close all

% Remember: check if ddphi dependent on ddtheta

syms g lc1 l1 l2 m1 m2 I1 I2;
syms phi theta;
syms dphi dtheta;
syms ddphi ddtheta;
q = [phi; theta];
dq = [dphi; dtheta];

% Define Lagrange equation

P = m2*g*l2*cos(theta);

dpc1 = [-dphi*lc1*sin(phi);
        dphi*lc1*cos(phi);
        0];
dpc2 = [-dphi*l1*sin(phi) - dtheta*l2*cos(theta)*cos(phi) + dphi*l2*sin(theta)*sin(phi);
        dphi*l1*cos(phi) + dtheta*l2*cos(theta)*sin(phi) + dphi*l2*sin(theta)*cos(phi);
        -dtheta*l2*sin(theta)];

wc1 = [0; 0; dphi];
wc2 = [cos(theta)*dphi; sin(theta)*dphi; dtheta];

K = 0.5*(m1*(dpc1.'*dpc1) + I1*(wc1.'*wc1) + m2*(dpc2.'*dpc2) + I2*(wc2.'*wc2));

L = K - P;

% Euler-lagrange

dl_dq = simplify(jacobian(L, dq));
syms t;
syms y1(t) y2(t) dy1(t) dy2(t);

dl_dq = subs(dl_dq, phi, y1);
dl_dq = subs(dl_dq, theta, y2);
dl_dq = subs(dl_dq, dphi, dy1);
dl_dq = subs(dl_dq, dtheta, dy2);

dt_dl_dq = diff(dl_dq, t);

dt_dl_dq = subs(dt_dl_dq, diff(y1,t), dphi);
dt_dl_dq = subs(dt_dl_dq, diff(y2,t), dtheta);
dt_dl_dq = subs(dt_dl_dq, diff(dy1,t), ddphi);
dt_dl_dq = subs(dt_dl_dq, diff(dy2,t), ddtheta);

dt_dl_dq = subs(dt_dl_dq, y1, phi);
dt_dl_dq = subs(dt_dl_dq, y2, theta);
dt_dl_dq = subs(dt_dl_dq, dy1, dphi);
dt_dl_dq = subs(dt_dl_dq, dy2, dtheta);

dl_q = simplify(jacobian(L, q));

eul_lag = simplify((dt_dl_dq - dl_q));


%% Linearization

% Add gen. force
syms u1 u2;
u = [u1; u2];
eul_lag = eul_lag - [u1, 0];

% Solve for ddq
f3 = solve(eul_lag(1,1), ddphi);
f4 = solve(eul_lag(1,2), ddtheta);

% If ddphi dependent on ddtheta: insert into eachother and solve again
% OBS: Dette avhenger av at det er et ikke-lineært ledd i L!!

f3 = subs(f3, ddtheta, f4);
f3 = f3 - ddphi;
f3 = simplify(solve(f3, ddphi));

f4 = subs(f4, ddphi, f3);
f4 = f4 - ddtheta;
f4 = simplify(solve(f4, ddtheta));

% Define linearized system
x = [phi; theta; dphi; dtheta];
f = [dphi; dtheta; f3; f4];

A = simplify(jacobian(f, x));
B = simplify(jacobian(f, u));

% Insert equlibrium

q_eq = [0; 0; 0; 0];

A = subs(A, phi, q_eq(1));
A = subs(A, theta, q_eq(2));
A = subs(A, dphi, q_eq(3));
A = subs(A, dtheta, q_eq(4));

B = subs(B, phi, q_eq(1));
B = subs(B, theta, q_eq(2));
B = subs(B, dphi, q_eq(3));
B = subs(B, dtheta, q_eq(4));


% Check controllability

C = [B A*B A*A*B A*A*A*B];
rank(C)

%%
C = [0 1 0 0];
O = [C; C*A; C*A^2; C*A^3


%%
z = [0 0 1];
syms a b c;
v = [a; b; c];
d = cross(z, v)






