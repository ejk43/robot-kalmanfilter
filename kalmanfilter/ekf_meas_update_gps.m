function [state_post, P_post] = ekf_meas_update_gps(x, P, z, Rk, dt, off)
% state = [x, y, theta, v, omega]'
% off = [x_off, y_off]' <- this is the lever arm offset
% z = [x_gps, y_gps] <- this is the actual GPS measurement reading

% Find the expected measurement: h(state)
gps_est = h_gps(x, off);
       
% Calculate H
H = zeros(2, size(x,1));
H(1,1) = 1;
H(1,3) = -off(1)*sin(x(3))-off(2)*cos(x(3));
H(2,2) = 1;
H(2,3) = off(1)*cos(x(3))-off(2)*sin(x(3));

% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
state_post = x + K*(z-gps_est);

% Find new covariance:
P_post = P - K*H*P;