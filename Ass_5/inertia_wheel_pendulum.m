
%% Task 1: frames
world = eye(3);

l_1 = 0.125;

syms q1;

I0 = world;
theta_1 = q1;
d_1 = 0;
a_1 = l_1;
alpha_1 = 0;
T_01 = (rot_z(theta_1)*trans_z(d_1))*(trans_x(a_1)*rot_x(alpha_1));

%% Task 2: kinetic energy

syms q1 q2;
syms dq1 dq2;
dq = [dq1, dq2].';

l_1 = 0.125;
l_c1 = 0.063;
m_1 = 0.02;
m_2 = 0.3;
I_1 = 4.7e-5;
I_2 = 3.2e-5;
g = 9.81;

%syms l_1 l_c1 m_1 m_2 I_1 I_2 g;


zero_vec = [0, 0 ,0].';

J_v1_1 = [-l_c1*sin(q1);
          l_c1*cos(q1);
          0];
J_v1_2 = zero_vec;
J_v2_1 = [-l_1*sin(q1);
          l_1*cos(q1);
          0];
J_v2_2 = zero_vec;

J_v1 = [J_v1_1, J_v1_2];
J_v2 = [J_v2_1, J_v2_2];

z_0 = [0, 0, 1].';
J_w1_1 = z_0;
J_w1_2 = zero_vec;
J_w2_1 = z_0;
J_w2_2 = z_0; % z_1 = z_0

J_w1 = [J_w1_1, J_w1_2];
J_w2 = [J_w2_1, J_w2_2];

v_c1 = J_v1*dq;
v_c2 = J_v2*dq;


w_1 = J_w1*dq;
w_2 = J_w2*dq;


K = 0.5*simplify((m_1*(v_c1.'*v_c1) + w_1.'*I_1*w_1) + (m_2*(v_c2.'*v_c2) + w_2.'*I_2*w_2));
P = g*sin(q1)*(m_1*l_c1 + m_2*l_1);

L = K - P;

dl_ddq = [diff(L, dq1), diff(L, dq2)].';
dl_dq = [diff(L, q1), diff(L, q2)].';

syms ddq1 ddq2;

dt_dl_ddq = 0.5*[2*ddq1*m_2*l_1^2 + 2*ddq1*m_1*l_c1^2 + 2*I_1*ddq1 + 2*I_2*ddq1 + 2*I_2*ddq2; 2*I_2*ddq1 + 2*I_2*ddq2];
         
eq = vpa(dt_dl_ddq - dl_dq, 2)

