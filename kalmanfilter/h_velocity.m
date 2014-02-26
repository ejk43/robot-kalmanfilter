function [meas] = h_velocity(x)
%H_VELOCITY Creates the velocity (ie, visual odometry) measurements
%   x = state <- state is m by n, where m = number of states, n = number of
%   samples to calculate. States 4:6 must be: [vel; omg; imubias]

% Find the expected measurement: h(state)
meas = [x(4,:); x(5,:)];