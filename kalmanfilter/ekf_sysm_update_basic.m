function [ state_pre, P_pre ] = ekf_sysm_update_basic(state, P, Qk, dt)
% state = [x, y, tht, v, omega]'


% Update State: x_pre = f(x,u), where x=state and u=0
state_pre = [state(1) + state(4)*dt*cos(state(3));
             state(2) + state(4)*dt*sin(state(3));
             state(3) + state(5)*dt;
             state(4);
             state(5)];
             
% Calculate Fk
Fk = [ 1 0 -state(4)*dt*sin(state(3)) dt*cos(state(3)) 0;
       0 1  state(4)*dt*cos(state(3)) dt*sin(state(3)) 0;
       0 0          1                      0          dt;
       0 0          0                      1           0;
       0 0          0                      0           1 ];

% Update Covariance: P_pre = F*P*F' + Qk
P_pre = Fk*P*Fk' + Qk;



end
