function drdt = drdt(t, r_t)
% Find dr

tau = r_t(4);
dtau = cos(t)*tau;

e_1 = [sin(2*tau)*cos(3*tau);
       sin(2*tau)*sin(3*tau);
       cos(2*tau)];
   
e_2 = -tau*[sin(2*tau)*sin(3*tau);
       sin(2*tau)*cos(3*tau);
       0];
e_3 = tau*cos(2*tau)*[cos(3*tau);
       sin(3*tau);
       -sin(2*tau)];

drho = dtau;
dphi = 3*dtau;
dtheta = 2*dtau;

dr = e_1*drho + e_2*dphi + e_3*dtheta;

drdt = [dr;dtau];