function [x_post, P_post] = ekf_meas_update_odom(x, P, z, Rk, dt, settings)
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'
% z = [vel_left; vel_right] <- this is the odom measurement reading

nStates = size(x,1);

b = settings.robot.track_m;

% Find the expected measurement: h(state)
% Calculate the Jacobian H
if settings.kf.useWheelError && settings.kf.useSystemParams
    odom_est = h_enc_full(x, b);
    H = [ ...
        0 0 0 x(9) -x(9)*b*x(11)/2  0 x(9) 0  (x(4)-b*x(11)*x(5)/2+x(7)) 0 -x(9)*b*x(5)/2;
        0 0 0 x(10) x(10)*b*x(11)/2 0 0 x(10) 0 (x(4)+b*x(11)*x(5)/2+x(8))  x(10)*b*x(5)/2 ];
    
elseif settings.kf.useSystemParams
    odom_est = h_enc_scale(x, b);
    H = [ ...
        0 0 0 x(7) -x(7)*b*x(9)/2 0 (x(4)-b*x(9)*x(5)/2) 0 -x(7)*b*x(5)/2;
        0 0 0 x(8)  x(8)*b*x(9)/2 0 0 (x(4)+b*x(9)*x(5)/2)  x(8)*b*x(5)/2 ];
    
elseif settings.kf.useWheelError
    odom_est = h_enc_verr(x, b);
    H = zeros(2, size(x,1));
    H(1,4) = 1;
    H(1,5) = -b/2;
    H(2,4) = 1;
    H(2,5) = +b/2;
    H(1,7) = 1;
    H(2,8) = 1;
    
else
    odom_est = h_enc_basic(x, b);
    H = zeros(2, size(x,1));
    H(1,4) = 1;
    H(1,5) = -b/2;
    H(2,4) = 1;
    H(2,5) = +b/2;
end


% Find Kalman Gain
K = P*H'*(H*P*H'+Rk)^-1;

% Find new state:
x_post = x + K*(z-odom_est);

% Find new covariance:
P_post = P - K*H*P;