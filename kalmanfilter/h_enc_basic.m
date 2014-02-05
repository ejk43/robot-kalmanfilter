function [meas] = h_enc_basic(x, b)
%H_ENC_BASIC Creates the basic encoder measurements
% state = [x, y, theta, v, omega, imubias]'

% odom_est = [x(4) - b/2*x(5);
%             x(4) + b/2*x(5)];

meas = [...
    x(4,:) - b./2.*x(5,:);
    x(4,:) + b./2.*x(5,:)];
