function [state_post, P_post] = ekf_meas_update_gps(state, P, z, Rk, dt, off)
% state = [x, y, theta, v, omega]'
% off = [x_off, y_off]' <- this is the lever arm offset
% z = [x_gps, y_gps] <- this is the actual GPS measurement reading

% Find the expected measurement: h(state)
gps_est = [state(1) + off(1)*cos(state(3)) - off(2)*sin(state(3));
           state(2) + off(1)*sin(state(3)) + off(2)*cos(state(3))];
       
% Calculate H
H = [ 1 0 -off(1)*sin(state(3))-off(2)*cos(state(3)) 0 0;
      0 1  off(1)*cos(state(3))-off(2)*sin(state(3)) 0 0];

% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
state_post = state + K*(z-gps_est);

% Find new covariance:
P_post = P - K*H*P;