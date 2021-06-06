clear
close all

syms theta;
ang = [pi; -theta];
axis = ['z'; 'z'];
n = length(ang);

Rs = sym('R', [3 3 n]);


for i=1:n
    if axis(i) == 'x'
        Rs(:, :, i) = [1 0 0;
                 0 cos(ang(i)) -sin(ang(i));
                 0 sin(ang(i)) cos(ang(i))];
    elseif axis(i) == 'y'
        Rs(:, :, i) = [cos(ang(i)) 0 sin(ang(i));
                 0 1 0;
                 -sin(ang(i)) 0 cos(ang(i))];
    else
        Rs(:, :, i) = [cos(ang(i)) -sin(ang(i)) 0;
                 sin(ang(i)) cos(ang(i)) 0;
                 0 0 1];
    end
end

Tot = Rs(:, :, 1);

for i=2:n
    Tot = Tot*Rs(:, :, i);
end

%Tot(abs(Tot) < 1e-5) = 0;

vpa(simplify(Tot), 2)

syms dphi;

Tot = Tot*[0; 0; dphi];
vpa(simplify(Tot), 2)



