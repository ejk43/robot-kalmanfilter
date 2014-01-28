function [x_post, P_post] = ekf_meas_update_odom(x, P, z, Rk, dt, b)
% state = [x, y, theta, v, omega]'
% z = [vel_left; vel_right] <- this is the actual GPS measurement reading

nStates = size(x,1);

% % Find the expected measurement: h(state)
% odom_est = [x(4) + b/2*x(5);
%             x(4) - b/2*x(5)];
       
% Calculate H
H = zeros(2, size(x,1));
H(1,4) = 1;
H(1,5) = b/2;
H(2,4) = 1;
H(2,5) = -b/2;
if nStates >= 8
    H(1,7) = 1;
    H(2,8) = 1;
end

odom_est = H*x;

% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
x_post = x + K*(z-odom_est);

% Find new covariance:
P_post = P - K*H*P;