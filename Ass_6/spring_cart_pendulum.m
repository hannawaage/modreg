
%% Task 1 - Lagrange eqs

syms x theta;
syms dx dtheta;
syms ddx ddtheta;

q = [x, theta];
dq = [dx; dtheta];
ddq = [ddx; ddtheta];

syms k m1 m2 g l;

P = 0.5*k*x^2 - m2*g*l*cos(theta);
dr = [dx + l*cos(theta)*dtheta;
      l*sin(theta)*dtheta];
K = simplify(0.5*m1*dx^2+0.5*m2*dr.'*dr);

delK_deldx = diff(K, dx);
delK_deldtheta = diff(K, dtheta);
delK_deldq = simplify([delK_deldx, delK_deldtheta].');
dt_delK_deldq = [ddx*(m1+m2) + ddtheta*m2*l*cos(theta) - dtheta^2*m2*l*sin(theta);
                 m2*l*(ddtheta*l + ddx*cos(theta)-dx*sin(theta)*dtheta)];

delK_delx = diff(K, x);
delK_deltheta = diff(K, theta);
delK_delq = [delK_delx, delK_deltheta].';

delP_delx = diff(P, x);
delP_deltheta = diff(P, theta);
delP_delq = [delP_delx, delP_deltheta].';

delL_delq = simplify(delK_delq - delP_delq);

lagrange_eq = simplify(dt_delK_deldq - delL_delq);

%% Task 2: Linearize the system

D = [m1+m2 m2*l*cos(theta);
     m2*l*cos(theta) m2*l^2];
C_dq = [-m2*l*dtheta^2*sin(theta);
        0];
G = [k*x; m2*g*l*sin(theta)];

lagrange_eq = simplify(D*ddq + C_dq + G);

syms F;
tau = [F; 0];

y = [dq; ddq];
ddq = simplify(D\(tau - C_dq -G));

delddq_delx = simplify(diff(ddq, x));
delddq_deltheta = simplify(diff(ddq, theta));

delf2 = D\(-C_dq);
delf2_delx = diff(delf2, x);
delf2_deltheta = diff(delf2, theta);

%% Find jacobian numeric values
x = 0;
theta = pi;

df21_delq_dtheta = (m2*(2*g*(-1) - g + dtheta^2*l*(-1)))/(m1 + m2 - m2*(-1)^2) - (2*m2*(-1)*0*(l*m2*sin(theta)*dtheta^2 + F - k*x + g*m2*cos(theta)*sin(theta)))/(m1 + m2 - m2*cos(theta)^2)^2;
df22_delq_dtheta = (2*m2*cos(theta)*0*(l*m2*cos(theta)*0*dtheta^2 + F*(-1) - k*x*(-1) + g*m1*0 + g*m2*0))/(l*(m1 + m2 - m2*(-1)^2)^2) - (2*(l*m2*(2*(-1)^2 - 1)*dtheta^2 - F*0 + g*m1*(-1) + g*m2*(-1) + k*x*0))/(l*(2*m1 + m2 - m2*(2*(-1)^2 - 1)));
df21_deldq_dtheta = 0;
df22_deldq_dtheta = 0;

%% Define linearized system

one_mat = eye(2);
delf2_delq = 1/m1*[-k -m2*g;
                   -k/l g*(m1+m2)];
delf2_deldq = 1/m1*[0 0;
                    0 0];
A_lin = [0*one_mat one_mat
         delf2_delq delf2_deldq];
delf2 = D\tau;
delf2_delu = diff(delf2, F);

B_lin = (1/m1)*[0 0 1 1/l].';

% Get controllability matrix
Co = simplify([B_lin A_lin*B_lin A_lin*A_lin*B_lin A_lin*A_lin*A_lin*B_lin]);
rank(Co);

%% Task 3 - LQR
l = 0.8;
k = 25;
m1 = 1;
m2 = 0.5;
g = 9.81;
A_lin = [0,                0, 1, 0;
         0,                0, 0, 1;
     -k/m1,       -(g*m2)/m1, 0, 0;
 -k/(l*m1), (g*(m1 + m2))/m1, 0, 0];
B_lin = [0, 0, 1/m1, 1/(l*m1)].';

Q = eye(4);
R = 1;
K = dlqr(A_lin, B_lin, Q, R);

%% Task 4 - Estimate ROA
syms x theta;
syms dx dtheta;
x = [x theta dx dtheta].';
dx = vpa((A_lin-B_lin*K)*x, 2)

           