function [ data, traj ] = generate_sensors(traj, trajsettings, settings)
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

%% Generate the trajectory state using the current KF settings
traj.x = traj.state(:,1:6);
if settings.kf.useWheelError
    traj.x = [traj.x, traj.state(:,7:8)];
end
if settings.kf.useSystemParams
    traj.x = [traj.x, traj.state(:,9:11)];
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
    traj.gps = h_gps(traj.state', settings.robot.off_gps)';
    data.gps(:,2:3) = interp1(traj.t, traj.gps, data.gps(:,1)) + gpsnoise;
end

nIMU = floor((te-ts)/ trajsettings.dt.imu)+1;
imunoise = trajsettings.std.imu*randn(nIMU,1);
if trajsettings.meas.useIMU
    % Generate Imu Measurements
    data.imu = zeros(nIMU, 2);
    data.imu(:,1) = ts:trajsettings.dt.imu:te;
    traj.imu = h_imu(traj.state');
    data.imu(:,2) = interp1(traj.t, traj.imu, data.imu(:,1)) + imunoise;
end

nOdom = floor((te-ts)/ trajsettings.dt.odom)+1;
odomnoise = trajsettings.std.odom*randn(nOdom,2);
if trajsettings.meas.useOdom
    % Generate Imu Measurements
    data.odom = zeros(nOdom, 2);
    data.odom(:,1) = ts:trajsettings.dt.odom:te;
    traj.odom = h_enc_full(traj.state', settings.robot.track_m)';
    data.odom(:,2:3) = interp1(traj.t, traj.odom, data.odom(:,1)) + odomnoise;
end

nRange = floor((te-ts)/ trajsettings.dt.ranger)+1;
rangenoise = trajsettings.std.ranger*randn(nRange,3);
if trajsettings.meas.useRanger
    % Generate Imu Measurements
    data.range = zeros(nRange, 4);
    data.range(:,1) = ts:trajsettings.dt.ranger:te;
    traj.range = h_ranger(traj.state', trajsettings.meas.rangerCoords)';
    data.range(:,2:4) = interp1(traj.t, traj.range, data.range(:,1)) + rangenoise;
end

nVel = floor((te-ts)/ trajsettings.dt.velocity)+1;
velnoise = trajsettings.std.velocity*randn(nVel,2);
if trajsettings.meas.useVelocity
    % Generate "Visual Odometry" velocity Measurements
    data.velocity = zeros(nVel, 2);
    data.velocity(:,1) = ts:trajsettings.dt.velocity:te;
    traj.velocity = h_velocity(traj.state')';
    data.velocity(:,2:3) = interp1(traj.t, traj.velocity, data.velocity(:,1)) + velnoise;
end

end

