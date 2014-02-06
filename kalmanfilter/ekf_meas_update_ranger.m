function [state_post, P_post] = ekf_meas_update_ranger(x, P, z, Rk, dt, loc)
% state = [x, y, theta, v, omega]'
% loc = [x1, y1; x2, y2; ...]' <- this is the ranger locations
% z = [d1; d2; ...] <- this is the actual ranger measurements

% Find the expected measurement: h(state)
d_est = h_ranger(x, loc);
       
% Calculate H
H = zeros(size(loc,1), size(x,1));
for ii = 1:size(loc,1)
    div = norm(x(1:2)-loc(ii,:)');
    H(ii,1) = (x(1) - loc(ii,1))/div;
    H(ii,2) = (x(2) - loc(ii,2))/div;
end

% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
state_post = x + K*(z-d_est);

% Find new covariance:
P_post = P - K*H*P;