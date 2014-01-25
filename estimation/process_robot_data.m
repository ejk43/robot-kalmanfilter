function [ hist, data ] = process_robot_data(settings, data)
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
[vel, omg] = convertEncodersToVelocity(data.enc(:,1), data.enc(:,2), data.enc(:,3));
data.odom = [ data.enc(1:end,1), [0;vel], [0;omg]];

nOdom = size(data.odom, 1);
nGPS = size(data.gps, 1);
nIMU = size(data.imu, 1);

%% Initialize KF
x = settings.kf.state;
P = diag(settings.kf.cov);
Q = diag([settings.sys.x^2,...
           settings.sys.y^2,...
           settings.sys.tht^2,...
           settings.sys.vel^2,...
           settings.sys.omg^2]);
R_gps = diag([settings.std.gps^2, settings.std.gps^2]);

hist.t = data.gps(:,1);
hist.x = zeros(nGPS, settings.kf.nStates);
hist.x_pre = zeros(nGPS, settings.kf.nStates);
hist.P = zeros(nGPS, settings.kf.nStates, settings.kf.nStates);
hist.P_pre = zeros(nGPS, settings.kf.nStates, settings.kf.nStates);
hist.Phi = zeros(nGPS, settings.kf.nStates, settings.kf.nStates);

%% GPS Smoothing
hist.x(1,:) = x;
hist.P(1,:,:) = P;
for idx_gps = 2:nGPS
    % Calculate dt based on GPS timestamp
    dt = data.gps(idx_gps,1)-data.gps(idx_gps-1,1);
    curr_time = data.gps(idx_gps,1);
    
    % System Update
    [ x_pre, P_pre, Phi ] = ekf_sysm_update_basic(x, P, Q*dt, dt);
    
    z = data.gps(idx_gps,2:3)';
    [ x, P ] = ekf_meas_update_gps(x_pre, P_pre, z, R_gps*dt, dt, settings.robot.off_gps);
    
    x(3) = CoerceAngle(x(3), 2*pi);
    
    hist.x(idx_gps,:) = x;
    hist.x_pre(idx_gps, :) = x_pre;
    hist.P(idx_gps,:,:) = P;
    hist.P_pre(idx_gps,:,:) = P_pre;
    hist.Phi(idx_gps,:,:) = Phi;
end

if settings.kf.smooth
    [hist.x_rts, hist.P_rts] = SmoothRTS(hist.Phi, hist.x, hist.x_pre, hist.P, hist.P_pre);
end

% % %% Main Filtering Loop
% % 
% % idx_gps = 1;
% % idx_imu = 1;
% % for idx_odom = 2:nOdom
% %     % Calculate dt based on odometry
% %     dt = data.odom(idx_odom,1)-data.odom(idx_odom-1,1);
% %     curr_time = data.odom(idx_odom,1);
% %     
% %     % System Update
% %     [ x_pre, P_pre ] = ekf_sysm_update_basic(x, P, Q*dt, dt)
% %     
% %     % Check for GPS measurement update
% %     if (data.gps(idx_gps,1) < curr_time)
% %         % GPS Measurement
% %         
% %     end
% %     
% %     % Check for IMU measurement update
% %     if (data.imu(idx_gps,1) < curr_time)
% %         % IMU Measurement
% %         
% %     end
% %     
% %     x = x_pre;
% %     P = P_pre;
% %     
% %     hist.x(idx_odom,:) = x;
% %     hist.x_pre
% % end


%% Smoothing?


if settings.plot
    plot_results
    h1 = figure(100);
    plot_robot(hist.x,20,h1);
    h2 = figure(101);
    plot_robot(hist.x_rts,20,h2);
end

end

