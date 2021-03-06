function [x_post, P_post] = ekf_meas_update_imu(x, P, z, Rk, dt)
% state = [x, y, theta, v, omega]'
% z = [omg_imu] <- this is the actual GPS measurement reading

% Find the expected measurement: h(state)
% imu_est = [x(5)-x(6)];
imu_est = h_imu(x);
       
% Calculate H
H = zeros(1, size(x,1));
H(1,5) = 1;
H(1,6) = 1;

% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
x_post = x + K*(z-imu_est);

% Find new covariance:
P_post = P - K*H*P;