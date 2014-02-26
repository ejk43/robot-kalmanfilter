function [x_post, P_post] = ekf_meas_update_velocity(x, P, z, Rk, dt)
% state = [x, y, theta, v, omega]'
% z = [v, omega] <- this is the velocity measurement reading

% Find the expected measurement: h(state)
% vel_est = [x(4); x(5)];
vel_est = h_velocity(x);
       
% Calculate H
H = zeros(1, size(x,1));
H(1,4) = 1;
H(2,5) = 1;

% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
x_post = x + K*(z-vel_est);

% Find new covariance:
P_post = P - K*H*P;