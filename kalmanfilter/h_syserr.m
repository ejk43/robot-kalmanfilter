function [meas] = h_syserr(x, settings)
%H_SYSERR Returns the system error parameters from the current state
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'
% OR
% state = [x, y, theta, v, omega, imubias, ...
%          scaleTpmL, scaleTpmR, scaleB]'

meas = [0; 0; 0];

if settings.kf.useWheelError && settings.kf.useSystemParams
    meas = [x(9); x(10); x(11)];
elseif settings.kf.useSystemParams
    meas = [x(7); x(8); x(9)];
end
