function [state_post, P_post] = ekf_pseudo_update_velerr(x, P, z, Rk, settings)
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'
% Perform an update which confines the wheel velocity error to 0 (verrL and
% verrR)

if ~settings.kf.useWheelError
    state_post = x;
    P_post = P;
    return;
end

% Find the expected measurement: h(state)
velerr_est = h_velerr(x, settings);

% Calculate H
H = zeros(2, size(x,1));
if settings.kf.useWheelError
    H(1,7) = 1;
    H(2,8) = 1;
end

% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
state_post = x + K*(z-velerr_est);

% Find new covariance:
P_post = P - K*H*P;