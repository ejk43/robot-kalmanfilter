function [meas] = h_imu(x)
%H_IMU Creates the IMU measurements
%   x = state <- state is m by n, where m = number of states, n = number of
%   samples to calculate. States 4:6 must be: [vel; omg; imubias]

% Find the expected measurement: h(state)
meas = x(5,:)+x(6,:);