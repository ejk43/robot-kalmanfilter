function [settings, traj_settings] = config_sim_wheelerror_only
% Simulation: Wheel Errors Only
% Set up the settings for a simulation trajectory with wheel errors

addpath('./../estimation');

%% Populate simulation Trajectory/ Sensor Settings
traj_settings = set_trajectory();

% Each segment is in the form:
%  [duration, forward velocity, angular velocity]
traj_settings.segments = [10, 1, 0;
    2, 0, pi/4;
    10, 1, 0;
    2, 0, pi/4;
    10, 1, 0;
    2, 0, pi/4;
    8, 1, 0;
    10, 1, pi/8;
    10, 1, -pi/8 ];
traj_settings.traj.dt = 1/100;
traj_settings.traj.vel_limit = 1;
traj_settings.traj.omg_limit = 1;


% Add faults
traj_settings.fault.useFault = 1;
traj_settings.fault.useSystemParams = 0;
traj_settings.fault.scaleL = 1;
traj_settings.fault.scaleR = 1;
traj_settings.fault.scaleB = 1;
% faultTime is a m x 2 array. m = # of faults. col = [start, end]
traj_settings.fault.faultTime = [20 30; 35 45];
% faultMagn is a m x 2 array. m = # of faults. col = [left, right]
traj_settings.fault.faultMagn = [0.5 0; 0 0.5];

% Measurement Noise
traj_settings.std.gps = 0.025;
traj_settings.std.imu = 0.002;
traj_settings.std.odom = 0.001;
traj_settings.std.ranger = 0.1;

% Measurement Rate
traj_settings.dt.gps = 1/10;
traj_settings.dt.imu = 1/25;
traj_settings.dt.odom = 1/50;
traj_settings.dt.ranger = 1/20;

% Measurement Generation
traj_settings.meas.imubias = 0.02;
traj_settings.meas.useGPS = 1;
traj_settings.meas.useIMU = 1;
traj_settings.meas.useOdom = 1;
traj_settings.meas.useRanger = 1;



%% Populate Kalman Filter settings
settings = set_defaults();

% Robot GPS offset
settings.robot.off_gps = [-0.45; 0]; % GPS offset in body frame

% KF Settings
settings.kf.useGPS = 1;
settings.kf.useIMU = 1;
settings.kf.useOdom = 1;
settings.kf.useWheelError = 1;
settings.kf.useSystemParams = 1;
settings.kf.useRanger = 0;
settings.kf.forceVelErr = 0;
settings.kf.forceSysErr = 1;

% System Noise
settings.sys.x = 0.01;
settings.sys.y = 0.01;
settings.sys.tht = 0.01;
settings.sys.vel = 0.1;
settings.sys.omg = 0.01;
settings.sys.verr_r = 0.01;
settings.sys.verr_l = 0.01;
settings.sys.imubias = 0.00005;

% Measurement Noise
settings.std.gps = 0.05;
settings.std.imu = 0.01;
settings.std.enc_eps = 0.005;
settings.std.enc_alp = 0.003;

% Initial Covariance
settings.cov.x = 100;
settings.cov.y = 100;
settings.cov.tht = pi;
settings.cov.vel = 1;
settings.cov.omg = 1;
settings.cov.imubias = 0.1;
settings.cov.verr_r = 0.0001;
settings.cov.verr_l = 0.0001;