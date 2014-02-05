function [meas] = h_enc_full(x, b)
%H_ENC_FULL Creates the Encoder measurements from the FULL state (shown below)
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'


% odomL = scaleL*v - scaleL*scaleB*b*w/2 + scaleL*verrL
% odomR = scaleR*v - scaleR*scaleB*b*w/2 + scaleR*verrR

meas = [ ...
    x(9,:).*x(4,:)  -  x(9,:).*b.*x(11,:).*x(5,:)./2 + x(9,:).*x(7,:);
    x(10,:).*x(4,:) + x(10,:).*b.*x(11,:).*x(5,:)./2 + x(10,:).*x(8,:)];