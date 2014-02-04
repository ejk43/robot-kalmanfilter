function [ state_pre, P_pre, Phi ] = ekf_sysm_update_basic(x, P, Qk, dt)
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'

% TODO: Clean up for different settings

% Update State: x_pre = f(x,u), where x=state and u=0
state_pre = [x(1) + x(4)*dt*cos(x(3)+x(5)*dt/2);
             x(2) + x(4)*dt*sin(x(3)+x(5)*dt/2);
             x(3) + x(5)*dt;
             x(4);
             x(5);
             x(6);
             x(7);
             x(8);
             x(9);
             x(10);
             x(11)];
             
% Calculate Phi (discrete transition matrix)
Phi = [ 1 0 -x(4)*dt*sin(x(3)+x(5)*dt/2) dt*cos(x(3)+x(5)*dt/2) -x(4)*dt*dt/2*sin(x(3)+x(5)*dt/2) 0 0 0 0 0 0;
        0 1  x(4)*dt*cos(x(3)+x(5)*dt/2) dt*sin(x(3)+x(5)*dt/2)  x(4)*dt*dt/2*cos(x(3)+x(5)*dt/2) 0 0 0 0 0 0;
        0 0        1                0      dt  0 0 0 0 0 0;
        0 0        0                1       0  0 0 0 0 0 0;
        0 0        0                0       1  0 0 0 0 0 0;
        0 0        0                0       0  1 0 0 0 0 0;
        0 0        0                0       0  0 1 0 0 0 0;
        0 0        0                0       0  0 0 1 0 0 0;
        0 0        0                0       0  0 0 0 1 0 0;
        0 0        0                0       0  0 0 0 0 1 0;
        0 0        0                0       0  0 0 0 0 0 1];

% Update Covariance: P_pre = F*P*F' + Qk
P_pre = Phi*P*Phi' + Qk;



end
