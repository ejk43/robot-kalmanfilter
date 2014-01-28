function [ hist, data, settings ] = process_robot_data(settings, data)
%PROCESS_ROBOT_DATA 

%% Set up the file path
addpath('./../preprocessing');
addpath('./../kalmanfilter');
addpath('./../plots');
addpath('./../util');

%% Load Settings (if not supplied)
if nargin < 1
    settings = [];
end
settings = set_defaults(settings);

%% Load Data (if not supplied)
if nargin < 2
    data = [];
end
data = load_data_ros(settings, data);

%% Preprocess as necessary

% Convert encoder data to odometry
[vel_rgt, vel_lft] = convertEncodersToWheelVelocity(data.enc(:,1), data.enc(:,2), data.enc(:,3));
data.odom = [ data.enc(1:end,1), [0;vel_rgt], [0;vel_lft]];

nOdom = size(data.odom, 1);
nGPS = size(data.gps, 1);
nIMU = size(data.imu, 1);

%% Initialize KF
[x, P, Q] = initialize_kf(settings);
nStates = size(x,1);
R_gps = diag([settings.std.gps^2, settings.std.gps^2]);
R_imu = settings.std.imu^2;

hist.t = data.gps(:,1);
hist.x = zeros(nGPS, nStates);
hist.x_pre = zeros(nGPS, nStates);
hist.P = zeros(nGPS, nStates, nStates);
hist.P_pre = zeros(nGPS, nStates, nStates);
hist.Phi = zeros(nGPS, nStates, nStates);

% %% GPS Smoothing
% hist.x(1,:) = x;
% hist.P(1,:,:) = P;
% for idx_gps = 2:nGPS
%     % Calculate dt based on GPS timestamp
%     dt = data.gps(idx_gps,1)-data.gps(idx_gps-1,1);
%     curr_time = data.gps(idx_gps,1);
%     
% %     % Odometry Measurement Update
% %     if settings.kf.useOdom
% %         odom = data.odom(data.gps(idx_gps-1,1)<data.odom(:,1) & data.odom(:,1)<data.gps(idx_gps,1), 2:3);
% %     end
%     
%     % System Update
%     [ x_pre, P_pre, Phi ] = ekf_sysm_update_basic(x, P, Q*dt, dt);
%     x_post = x_pre;
%     P_post = P_pre;
%     
%     % GPS Measurement Update
%     if settings.kf.useGPS
%         z_gps = data.gps(idx_gps,2:3)';
%         [ x_post, P_post ] = ekf_meas_update_gps(x_post, P_post, z_gps, R_gps*dt, dt, settings.robot.off_gps);
%     end
%     
%     % IMU Measurement Update
%     if settings.kf.useIMU
%         z_imu = mean(data.imu(data.gps(idx_gps-1,1)<data.imu(:,1) & data.imu(:,1)<data.gps(idx_gps,1), 2));
%         [ x_post, P_post ] = ekf_meas_update_imu(x_post, P_post, z_imu, R_imu*dt, dt);
%     end
%     
%     x = x_post;
%     P = P_post;
%     
%     hist.x(idx_gps,:) = x;
%     hist.x_pre(idx_gps, :) = x_pre;
%     hist.P(idx_gps,:,:) = P;
%     hist.P_pre(idx_gps,:,:) = P_pre;
%     hist.Phi(idx_gps,:,:) = Phi;
% end
% 
% if settings.kf.smooth
%     [hist.x_rts, hist.P_rts] = SmoothRTS(hist.Phi, hist.x, hist.x_pre, hist.P, hist.P_pre);
% end

%% Main Filtering Loop

hist.t = data.odom(:,1);
hist.x = zeros(nOdom, nStates);
hist.x_pre = zeros(nOdom, nStates);
hist.P = zeros(nOdom, nStates, nStates);
hist.P_pre = zeros(nOdom, nStates, nStates);
hist.Phi = zeros(nOdom, nStates, nStates);

dt_gps = mean(diff(data.gps(:,1))); % Hack for timestep- we need to calculate in each loop
dt_imu = mean(diff(data.imu(:,1))); % Hack for timestep- we need to calculate in each loop
for idx_odom = 2:nOdom
    % Calculate dt based on odometry
    dt = data.odom(idx_odom,1)-data.odom(idx_odom-1,1);
    curr_time = data.odom(idx_odom,1);
    
    % System Update
    [ x_pre, P_pre, Phi ] = ekf_sysm_update_basic(x, P, Q*dt, dt);
    x_post = x_pre;
    P_post = P_pre;
    
    % Odometry Measurement Update
    if settings.kf.useOdom
        z_odom = data.odom(idx_odom,2:3)';
        R_odom = diag([settings.std.enc_alp*abs(z_odom(1)) + settings.std.enc_eps, ...
            settings.std.enc_alp*abs(z_odom(2)) + settings.std.enc_eps]);
        [ x_post, P_post ] = ekf_meas_update_odom(x_post, P_post, z_odom, R_odom*dt, dt, settings.robot.track_m);
    end
    
    % GPS Measurement Update
    if settings.kf.useGPS
        z_gps = data.gps(data.odom(idx_odom-1,1)<data.gps(:,1) & data.gps(:,1)<data.odom(idx_odom,1), 2:3)';
        if ~isempty(z_gps)
            [ x_post, P_post ] = ekf_meas_update_gps(x_post, P_post, z_gps, R_gps*dt_gps, dt_gps, settings.robot.off_gps);
        end
    end
    
    % IMU Measurement Update
    if settings.kf.useIMU
        z_imu = data.imu(data.odom(idx_odom-1,1)<data.imu(:,1) & data.imu(:,1)<data.odom(idx_odom,1), 2);
        if ~isempty(z_imu)
            [ x_post, P_post ] = ekf_meas_update_imu(x_post, P_post, z_imu, R_imu*dt_imu, dt_gps);
        end
    end
    
    x = x_post;
    P = P_post;
    
    hist.x(idx_odom,:) = x;
    hist.x_pre(idx_odom, :) = x_pre;
    hist.P(idx_odom,:,:) = P;
    hist.P_pre(idx_odom,:,:) = P_pre;
    hist.Phi(idx_odom,:,:) = Phi;
end

if settings.kf.smooth
    [hist.x_rts, hist.P_rts] = SmoothRTS(hist.Phi, hist.x, hist.x_pre, hist.P, hist.P_pre);
end

%% Plotting


if settings.plot
    plot_results
    
    h1 = figure(100); clf; hold on;
    plot(hist.x(:,1),hist.x(:,2), '.');
    plot_robot(hist.x,20,h1);
    
    h2 = figure(101); clf; hold on;
    plot(hist.x_rts(:,1),hist.x_rts(:,2), '.');
    plot_robot(hist.x_rts,20,h2);
end

end

