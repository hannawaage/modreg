
world = eye(3);

t_z = trans_z(1);

I0 = world;
theta_1 = 0;
d_1 = 2.202;
a_1 = 0;
alpha_1 = pi/2; 
A_01 = (rot_z(theta_1)*trans_z(d_1))*(trans_x(a_1)*rot_x(alpha_1));
A_01 = A_01(1:3, 1:3);
I1 = A_01 * I0

theta_2_0 = 0.1192;
theta_2 = theta_2_0;
d_2 = 0;
a_2 = 1.4;
alpha_2 = 0; 
A_12 = (rot_z(theta_2)*trans_z(d_2))*(trans_x(a_2)*rot_x(alpha_2));
A_12 = A_12(1:3, 1:3);
I2 = A_01 * A_12 

theta_3 = pi/2 - theta_2_0;
d_3 = 0;
a_3 = 0.104;
alpha_3 = pi/2; 
A_23 = (rot_z(theta_3)*trans_z(d_3))*(trans_x(a_3)*rot_x(alpha_3));
A_23 = A_23(1:3, 1:3);
I3 = A_01 * A_12 * A_23

theta_4 = 0;
d_4 = 1.813;
a_4 = 0;
alpha_4 = -pi/2; 
A_34 = (rot_z(theta_4)*trans_z(d_4))*(trans_x(a_4)*rot_x(alpha_4));
A_34 = A_34(1:3, 1:3);
I4 = A_01 * A_12 * A_23 * A_34
