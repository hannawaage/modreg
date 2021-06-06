
syms l1 l2 l3 t1 t2 t3 d2 d3;
n_links = 2;

thetas = [t1; 0];
ds = [l1; d2];
as = [0; 0];
alphas = [0; -pi/2];

As = sym('A', [4 4 n_links]);

for i=1:n_links
    rot_z = [cos(thetas(i)) -sin(thetas(i)) 0 0;
             sin(thetas(i)) cos(thetas(i)) 0 0;
             0 0 1 0;
             0 0 0 1];
    trans_z = [1 0 0 0;
               0 1 0 0;
               0 0 1 ds(i);
               0 0 0 1];
    trans_x = [1 0 0 0;
               0 1 0 0;
               0 0 1 as(i);
               0 0 0 1];
    rot_x = [1 0 0 0;
             0 cos(alphas(i)) -sin(alphas(i)) 0;
             0 sin(alphas(i)) cos(alphas(i)) 0;
             0 0 0 1];
    As(:, :, i) = rot_z*trans_z*trans_x*rot_x;
end

T = As(:, :, 1);
for i=2:n_links
    T = T*As(:, :, i);
end

vpa(T, 2)


