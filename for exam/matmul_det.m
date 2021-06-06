syms sq3;

M1 = [sq3/2 -0.5 0;
      0.5 sq3/2 0;
      0 0 1];
M2 = [1 0 0;
      0 0.5 sq3/2;
      0 -sq3/2 0.5];
M3 = [0 1 0;
      -1 0 1;
      0 -1 0];
  
  
Ma = M1*inv(M2)*M3;

Ma = subs(Ma, sq3^2, 3)

Ma*Ma.';
Ma.'

%%
Mb = M1*M3*inv(M1);
Mb = subs(Mb, sq3^2, 3);

Mb*Mb.'

%%
Mc = M1*M2*inv(M1);
Mc = subs(Mc, sq3^2, 3);

t = Mc*Mc.';
t = subs(t, sq3^2, 3);

%%
M3^0

%%

M3
2
M3^2
3
M3^3
4
M3^4
5
M3^5
6
M3^6
7
M3^7
8
M3^8
9
M3^9
10
M3^10
%%

syms k;

M = [0 (-2)^((k-1)/2) 0;
     (-1)^((k-1)/2+1)*2^((k-1)/2) 0 (-2)^((k-1)/2);
    0 (-1)^((k-1)/2+1)*2^((k-1)/2) 0];
M = subs(M, k, 43)
M3^43

%%
M = [(-1)^(k/2)*2^(k/2-1) 0 (-2)^(k/2-1);
     0 (-2)^(k/2) 0;
    (-2)^(k/2-1) 0 (-1)^(k/2)*2^(k/2-1)];
M = subs(M, k, 12)
M3^12

%%
syms c s sq2;
M3x = [cos(sqrt(2))/2 sin(sqrt(2))/sqrt(2) -cos(sqrt(2))/2;
      -sin(sqrt(2))/sqrt(2) cos(sqrt(2)) sin(sqrt(2))/sqrt(2);
      -cos(sqrt(2))/2 -sin(sqrt(2))/sqrt(2) cos(sqrt(2))/2];
 
% M3x = [0.5*c (1/sq2)*s -0.5*c;
%        -(1/sq2)*s c (1/sq2)*s;
%        -0.5*c -(1/sq2)*s 0.5*c];

Md = M2*M3x*inv(M1);
Md = subs(Md, sq3^2, 3);
Md = subs(Md, sq2^2, 2);
Md = subs(Md, sq3, sqrt(3));
Md = subs(Md, sq2, sqrt(2));

vpa(Md*Md.', 2)

vpa(Md, 2)
%vpa(Md + Md.', 2)

 
 
 
