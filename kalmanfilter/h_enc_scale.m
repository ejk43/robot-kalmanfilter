function [meas] = h_enc_scale(x, b)
%H_ENC_SCALE Creates the Encoder measurements from the 
% state with systematic error states only (shown below)
% state = [x, y, theta, v, omega, imubias, ...
%          scaleTpmL, scaleTpmR, scaleB]'


% odomL = scaleL*v - scaleL*scaleB*b*w/2
% odomR = scaleR*v - scaleR*scaleB*b*w/2

meas = [ ...
    x(7,:).*x(4,:) - x(7,:).*b.*x(9,:).*x(5,:)./2;
    x(8,:).*x(4,:) + x(8,:).*b.*x(9,:).*x(5,:)./2];