function [meas] = h_velerr(x, settings)
%H_VELERR Returns the wheel velocity error from the current state
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'
% OR
% state = [x, y, theta, v, omega, imubias, ...
%          scaleTpmL, scaleTpmR, scaleB]'

meas = [0; 0];

if settings.kf.useWheelError
    meas = [x(7); x(8)];
end
