
world = eye(3);

t_z = trans_z(1);

syms q1 q2 q3 q4;


I0 = world;
theta_1 = q1;
d_1 = 2.202;
a_1 = 0;
alpha_1 = pi/2; 
A_01 = (rot_z(theta_1)*trans_z(d_1))*(trans_x(a_1)*rot_x(alpha_1));
I1 = A_01;

theta_2_0 = 0.1192;
theta_2 = q2 + theta_2_0;
d_2 = 0;
a_2 = 1.4;
alpha_2 = 0; 
A_12 = (rot_z(theta_2)*trans_z(d_2))*(trans_x(a_2)*rot_x(alpha_2));
I2 = A_01 * A_12;

theta_3 = pi/2 + q3 - theta_2_0;
d_3 = 0;
a_3 = 0.104;
alpha_3 = pi/2; 
A_23 = (rot_z(theta_3)*trans_z(d_3))*(trans_x(a_3)*rot_x(alpha_3));
I3 = A_01 * A_12 * A_23;

theta_4 = 0;
d_4 = q4 + 1.813;
a_4 = 0;
alpha_4 = -pi/2; 
A_34 = (rot_z(theta_4)*trans_z(d_4))*(trans_x(a_4)*rot_x(alpha_4));

I4 = simplify(A_01 * A_12 * A_23 * A_34);

pos_origin = vpa(I4(1:3, 4), 2)



