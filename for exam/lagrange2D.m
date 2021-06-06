clear
close all

% Remember: check if ddq1 dependent on ddq2

syms g l m M;
syms q1 q2;
syms dq1 dq2;
syms ddq1 ddq2;
q = [q1; q2];
dq = [dq1; dq2];

% Define Lagrange equation

P = m*g*cos(q2);

K = 0.5*(dq1^2*(M+m) + m*l^2*dq2^2 + 2*m*dq1*dq2*l*cos(q2));

L = K - P;

% Euler-lagrange

dl_dq = simplify(jacobian(L, dq));
syms t;
syms y1(t) y2(t) dy1(t) dy2(t);

dl_dq = subs(dl_dq, q1, y1);
dl_dq = subs(dl_dq, q2, y2);
dl_dq = subs(dl_dq, dq1, dy1);
dl_dq = subs(dl_dq, dq2, dy2);

dt_dl_dq = diff(dl_dq, t);

dt_dl_dq = subs(dt_dl_dq, diff(y1,t), dq1);
dt_dl_dq = subs(dt_dl_dq, diff(y2,t), dq2);
dt_dl_dq = subs(dt_dl_dq, diff(dy1,t), ddq1);
dt_dl_dq = subs(dt_dl_dq, diff(dy2,t), ddq2);

dt_dl_dq = subs(dt_dl_dq, y1, q1);
dt_dl_dq = subs(dt_dl_dq, y2, q2);
dt_dl_dq = subs(dt_dl_dq, dy1, dq1);
dt_dl_dq = subs(dt_dl_dq, dy2, dq2);

dl_q = simplify(jacobian(L, q));

eul_lag = simplify((dt_dl_dq - dl_q));


%% Linearization

% Add gen. force
syms u1 u2;
u = [u1; u2];
eul_lag = eul_lag - [u1, 0];

% Solve for ddq
f3 = solve(eul_lag(1,1), ddq1);
f4 = solve(eul_lag(1,2), ddq2);

% If ddq1 dependent on ddq2: insert into eachother and solve again
% OBS: Dette avhenger av at det er et ikke-lineært ledd i L!!

f3 = subs(f3, ddq2, f4);
f3 = f3 - ddq1;
f3 = simplify(solve(f3, ddq1));

f4 = subs(f4, ddq1, f3);
f4 = f4 - ddq2;
f4 = simplify(solve(f4, ddq2));

% Define linearized system
x = [q1; q2; dq1; dq2];
f = [dq1; dq2; f3; f4];

A = simplify(jacobian(f, x));
B = simplify(jacobian(f, u));

% Insert equlibrium

q_eq = [0; 0; 0; 0];

A = subs(A, q1, q_eq(1));
A = subs(A, q2, q_eq(2));
A = subs(A, dq1, q_eq(3));
A = subs(A, dq2, q_eq(4));

B = subs(B, q1, q_eq(1));
B = subs(B, q2, q_eq(2));
B = subs(B, dq1, q_eq(3));
B = subs(B, dq2, q_eq(4));


% Check controllability

C = [B A*B A*A*B A*A*A*B];
rank(C)

