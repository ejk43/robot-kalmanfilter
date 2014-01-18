function [state, P] = extended_kalman_filter(state, P, z_gps)
% state = [x, y, theta, v, omega]'
% P = covariance matrix
% z_gps = [x_gps, y_gps] 
% Goal: Use the new GPS measurement to update the EKF state and covariance

% Set constants (Or pass into the function)
dt = 0.1;          % 10 Hz
Q = diag([0.01, 0.01, 0.001, 0.3, 0.3]);
Qk = Qk(dt); % <- System (Process) Noise
R_gps = [0.1^2   0; 
      0    0.1^2];
Rk_gps = R_gps*dt; % <- Measurement Noise
off = [0.25; 0];  % <- GPS lever arm offset. x_off = 0.25, y_off = 0

% Extended Kalman Filter:
[state_pre, P_pre] = system_update(state, P, Qk, dt);
[state, P] = meas_update_gps(state_pre, P_pre, z_gps, Rk, Rk, dt, off);
