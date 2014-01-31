function [ data ] = generate_sensors(traj, trajsettings, settings)
%GENERATE TRAJECTORY creates a robot path and returns the true state

%% Set up the file path
addpath('./../preprocessing');
addpath('./../kalmanfilter');
addpath('./../plots');
addpath('./../util');

%% Load Settings (if not supplied)
if nargin < 3
    settings = [];
end
settings = set_defaults(settings);

if nargin < 2
    trajsettings = [];
end
trajsettings = set_trajectory(trajsettings);

if nargin < 1
    traj = generate_trajectory(trajsettings);
end

%% Generate the Sensor Data
plotNum = 200;

ts = traj.t(1);
te = traj.t(end);

nGPS = floor((te-ts)/ trajsettings.dt.gps)+1;
gpsnoise = trajsettings.std.gps*randn(nGPS,2);
if trajsettings.meas.useGPS
    % Generate GPS Measurements
    data.gps = zeros(nGPS, 3);
    data.gps(:,1) = ts:trajsettings.dt.gps:te;
    allgps = h_gps(traj.state', settings.robot.off_gps)';
    data.gps(:,2:3) = interp1(traj.t, allgps, data.gps(:,1)) + gpsnoise;
    
    if trajsettings.plot
        figure(plotNum); plotNum = plotNum + 1;
        plot(traj.state(:,1), traj.state(:,2), 'b.', allgps(:,1), allgps(:,2), 'r.', data.gps(:,2), data.gps(:,3), 'ko');
        xlabel('X (m)'); ylabel('Y (m)');
        title('Robot Track and Measurements');
        legend('True', 'Perfect GPS', 'Downsampled Noisy GPS');
        axis square;
    end
end

nIMU = floor((te-ts)/ trajsettings.dt.imu)+1;
imunoise = trajsettings.std.imu*randn(nIMU,1);
if trajsettings.meas.useIMU
    % Add the imu bias into the state
    traj.state = [traj.state, trajsettings.meas.imubias*ones(size(traj.state,1),1)];
    
    % Generate Imu Measurements
    data.imu = zeros(nIMU, 2);
    data.imu(:,1) = ts:trajsettings.dt.imu:te;
    allimu = h_imu(traj.state');
    data.imu(:,2) = interp1(traj.t, allimu, data.imu(:,1)) + imunoise;
    
    if trajsettings.plot
        figure(plotNum); plotNum = plotNum + 1;
        plot(traj.t, traj.state(:,5), 'b.', traj.t, allimu, 'r.', data.imu(:,1), data.imu(:,2), 'ko');
        xlabel('Time (s)'); ylabel('Angular Velocity (rad/s)');
        title('Imu Truth and Measurements')
        legend('True', 'Perfect IMU', 'Downsampled Noisy IMU');
    end
end

nOdom = floor((te-ts)/ trajsettings.dt.odom)+1;
odomnoise = trajsettings.std.odom*randn(nOdom,2);
if trajsettings.meas.useOdom
    % Generate Imu Measurements
    data.odom = zeros(nOdom, 2);
    data.odom(:,1) = ts:trajsettings.dt.odom:te;
    allodom = h_enc(traj.state', settings.robot.track_m)';
    data.odom(:,2:3) = interp1(traj.t, allodom, data.odom(:,1)) + odomnoise;
    
    if trajsettings.plot
        figure(plotNum); plotNum = plotNum + 1; px = [];
        px(1) = subplot(2,1,1);
        plot(traj.t, allodom(:,1), 'r.', data.odom(:,1), data.odom(:,2), 'ko');
        xlabel('Time (s)'); ylabel('Forward Velocity (m/s)');
        title('Left Wheel Odometry Measurements')
        legend('Perfect Odom', 'Downsampled Noisy Odom');
        px(2) = subplot(2,1,2);
        plot(traj.t, allodom(:,2), 'r.', data.odom(:,1), data.odom(:,3), 'ko');
        xlabel('Time (s)'); ylabel('Forward Velocity (m/s)');
        title('Right Wheel Odometry Measurements')
        legend('Perfect Odom', 'Downsampled Noisy Odom');
    end
end


end

