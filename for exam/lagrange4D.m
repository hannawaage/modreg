clear
close all

% Remember: check if ddq1 dependent on ddq2

syms g l m M;
syms q1 q2 q3 q4;
syms dq1 dq2 dq3 dq4;
syms ddq1 ddq2 ddq3 ddq4;
q = [q1; q2; q3; q4];
dq = [dq1; dq2; dq3; dq4];

% Define Lagrange equation

P = m*g*cos(q2) + m*g*cos(q4);

K = 0.5*((M+m)*dq1^2 + m*l^2*dq2^2 + 2*m*l*dq1*dq2*cos(q2) + (M+m)*dq3^2 + m*l^2*dq4^2 + 2*m*l*dq3*dq4*cos(q4));

L = K - P;

% Euler-lagrange

dl_dq = simplify(jacobian(L, dq));
syms t;
syms y1(t) y2(t) y3(t) y4(t) dy1(t) dy2(t) dy3(t) dy4(t);

dl_dq = subs(dl_dq, q1, y1);
dl_dq = subs(dl_dq, q2, y2);
dl_dq = subs(dl_dq, q3, y3);
dl_dq = subs(dl_dq, q4, y4);
dl_dq = subs(dl_dq, dq1, dy1);
dl_dq = subs(dl_dq, dq2, dy2);
dl_dq = subs(dl_dq, dq3, dy3);
dl_dq = subs(dl_dq, dq4, dy4);

dt_dl_dq = diff(dl_dq, t);

dt_dl_dq = subs(dt_dl_dq, diff(y1,t), dq1);
dt_dl_dq = subs(dt_dl_dq, diff(y2,t), dq2);
dt_dl_dq = subs(dt_dl_dq, diff(y3,t), dq3);
dt_dl_dq = subs(dt_dl_dq, diff(y4,t), dq4);

dt_dl_dq = subs(dt_dl_dq, diff(dy1,t), ddq1);
dt_dl_dq = subs(dt_dl_dq, diff(dy2,t), ddq2);
dt_dl_dq = subs(dt_dl_dq, diff(dy3,t), ddq3);
dt_dl_dq = subs(dt_dl_dq, diff(dy4,t), ddq4);

dt_dl_dq = subs(dt_dl_dq, y1, q1);
dt_dl_dq = subs(dt_dl_dq, y2, q2);
dt_dl_dq = subs(dt_dl_dq, y3, q3);
dt_dl_dq = subs(dt_dl_dq, y4, q4);

dt_dl_dq = subs(dt_dl_dq, dy1, dq1);
dt_dl_dq = subs(dt_dl_dq, dy2, dq2);
dt_dl_dq = subs(dt_dl_dq, dy3, dq3);
dt_dl_dq = subs(dt_dl_dq, dy4, dq4);

dl_q = simplify(jacobian(L, q));

eul_lag = simplify((dt_dl_dq - dl_q));


%% Linearization

% Add gen. force
syms u1 u2 u3 u4;
u = [u1; u2; u3; u4];
eul_lag = eul_lag - [0, u2, 0, u4];

% Solve for ddq
f5 = solve(eul_lag(1,1), ddq1);
f6 = solve(eul_lag(1,2), ddq2);
f7 = solve(eul_lag(1,3), ddq3);
f8 = solve(eul_lag(1,4), ddq4);

% If ddq1 dependent on ddq2: insert into eachother and solve again
% Antar her at 1 og 2 er dep og 3 og 4
% OBS: Dette avhenger av at det er et ikke-lineært ledd i L!!

f5 = subs(f5, ddq2, f6);
f5 = f5 - ddq1;
f5 = simplify(solve(f5, ddq1));

f6 = subs(f6, ddq1, f5);
f6 = f6 - ddq2;
f6 = simplify(solve(f6, ddq2));

f7 = subs(f7, ddq4, f8);
f7 = f7 - ddq3;
f7 = simplify(solve(f7, ddq3));

f8 = subs(f8, ddq3, f7);
f8 = f8 - ddq4;
f8 = simplify(solve(f8, ddq4));

% Define linearized system
x = [q1; q2; q3; q4; dq1; dq2; dq3; dq4];
f = [dq1; dq2; dq3; dq4; f5; f6; f7; f8];

A = simplify(jacobian(f, x));
B = simplify(jacobian(f, u));

% Insert equlibrium

q_eq = [0; 0; 0; 0; 0; 0; 0; 0];

A = subs(A, q1, q_eq(1));
A = subs(A, q2, q_eq(2));
A = subs(A, q3, q_eq(3));
A = subs(A, q4, q_eq(4));

A = subs(A, dq1, q_eq(5));
A = subs(A, dq2, q_eq(6));
A = subs(A, dq3, q_eq(7));
A = subs(A, dq4, q_eq(8));

B = subs(B, q1, q_eq(1));
B = subs(B, q2, q_eq(2));
B = subs(B, q3, q_eq(3));
B = subs(B, q4, q_eq(4));

B = subs(B, dq1, q_eq(5));
B = subs(B, dq2, q_eq(6));
B = subs(B, dq3, q_eq(7));
B = subs(B, dq4, q_eq(8));


% Check controllability

C = [B A*B A*A*B A*A*A*B];
rank(C)

