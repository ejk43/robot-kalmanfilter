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
data.odom = add_odom_fault(data.odom, settings);

%% Preprocess as necessary
nOdom = size(data.odom, 1);
nGPS = size(data.gps, 1);
nIMU = size(data.imu, 1);

%% Initialize KF
[x, P, Q, R] = initialize_kf(settings);
nStates = size(x,1);

hist.t = data.gps(:,1);
hist.x = zeros(nGPS, nStates);
hist.x_pre = zeros(nGPS, nStates);
hist.P = zeros(nGPS, nStates, nStates);
hist.P_pre = zeros(nGPS, nStates, nStates);
hist.Phi = zeros(nGPS, nStates, nStates);

%% Main Filtering Loop

hist.t = data.odom(:,1);
hist.x = zeros(nOdom, nStates);
hist.x_pre = zeros(nOdom, nStates);
hist.P = zeros(nOdom, nStates, nStates);
hist.P_pre = zeros(nOdom, nStates, nStates);
hist.Phi = zeros(nOdom, nStates, nStates);

dt_gps = mean(diff(data.gps(:,1))); % Hack for timestep- we need to calculate in each loop
dt_imu = mean(diff(data.imu(:,1))); % Hack for timestep- we need to calculate in each loop
dt_range = mean(diff(data.range(:,1))); % Hack for timestep- we need to calculate in each loop
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
        R.odom = diag([settings.std.enc_alp*abs(z_odom(1)) + settings.std.enc_eps, ...
            settings.std.enc_alp*abs(z_odom(2)) + settings.std.enc_eps]);
        [ x_post, P_post ] = ekf_meas_update_odom(x_post, P_post, z_odom, R.odom*dt, dt, settings);
    end
    
    % GPS Measurement Update
    if settings.kf.useGPS
        z_gps = data.gps(data.odom(idx_odom-1,1)<data.gps(:,1) & data.gps(:,1)<=data.odom(idx_odom,1), 2:3)';
        if ~isempty(z_gps)
            [ x_post, P_post ] = ekf_meas_update_gps(x_post, P_post, z_gps, R.gps*dt_gps, dt_gps, settings.robot.off_gps);
        end
    end
    
    % IMU Measurement Update
    if settings.kf.useIMU
        z_imu = data.imu(data.odom(idx_odom-1,1)<data.imu(:,1) & data.imu(:,1)<=data.odom(idx_odom,1), 2);
        if ~isempty(z_imu)
            [ x_post, P_post ] = ekf_meas_update_imu(x_post, P_post, z_imu, R.imu*dt_imu, dt_gps);
        end
    end
    
    % Ranger Measurement Update
    if settings.kf.useRanger
        z_range = data.range(data.odom(idx_odom-1,1)<data.range(:,1) & data.range(:,1)<=data.odom(idx_odom,1), 2:end)';
        if ~isempty(z_range)
            [ x_post, P_post ] = ekf_meas_update_ranger(x_post, P_post, z_range, R.range*dt_range, dt_range, settings.env.rangerCoords);
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
    plot_timelapse
end

end

