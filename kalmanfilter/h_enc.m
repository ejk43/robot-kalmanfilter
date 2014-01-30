function [meas] = h_enc(x, b)
%H_ENC Creates the Encoder measurements
% state = [x, y, theta, v, omega]'
% z = [vel_left; vel_right] <- this is the odom measurement reading

% % Find the expected measurement: h(state)
% odom_est = [x(4) - b/2*x(5);
%             x(4) + b/2*x(5)];

meas = [x(4,:) - b./2.*x(5,:);
    x(4,:) + b./2.*x(5,:)];

if size(x,1)>=8
    meas = meas + [x(7,:); x(8,:)];
end
