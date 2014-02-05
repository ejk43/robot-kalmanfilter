function [meas] = h_enc_verr(x, b)
%H_ENC_VERR Creates the Encoder measurements from the 
% state with non-systematic error states only (shown below)
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR]'

% odomL = v - b*w/2 + verrL
% odomR = v - b*w/2 + verrR

meas = [ ...
    x(4,:) - b.*x(5,:)./2 + x(7,:);
    x(4,:) + b.*x(5,:)./2 + x(8,:)];