function out1 = ode_fun_t(t, R, task)
%ODE_FUN_T
%    OUT1 = ODE_FUN_T(R2_1,R2_2,R2_3,R3_1,R3_2,R3_3)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    05-Feb-2021 12:50:21

if task == 'b'
    w = [cos(t) sin(t) 0].';
else
    w = [cos(2*t)^3 sin(2*t)^3 0].';
end
S = cross2mat(w);
R = reshape(R(1:9), [3,3]);
out1 = [reshape(S*R, [9,1]); w];