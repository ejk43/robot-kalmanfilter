function [state_post, P_post] = ekf_pseudo_update_syserr(x, P, z, Rk, settings)
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'

if ~settings.kf.useSystemParams
    state_post = x;
    P_post = P;
    return;
end

% Find the expected measurement: h(state)
syserr_est = h_syserr(x, settings);

% Calculate H
H = zeros(3, size(x,1));
if settings.kf.useWheelError && settings.kf.useSystemParams
    H(1,9) = 1;
    H(2,10) = 1;
    H(3,11) = 1;
elseif settings.kf.useSystemParams
    H(1,7) = 1;
    H(2,8) = 1;
    H(3,9) = 1;
end

% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
state_post = x + K*(z-syserr_est);

% Find new covariance:
P_post = P - K*H*P;