function rot_x = rot_x(alpha)

rot_x = [1 0 0 0;
         0 cos(alpha) -sin(alpha) 0;
         0 sin(alpha) cos(alpha) 0;
         0 0 0 1];
end