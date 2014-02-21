function [settings, traj_settings] = config_montecarlo_systemerror_only
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
traj_settings.fault.useFault = 0;
traj_settings.fault.useSystemParams = 1;
traj_settings.fault.scaleL = 0.8;
traj_settings.fault.scaleR = 1.2;
traj_settings.fault.scaleB = 1.05;
% faultTime is a m x 2 array. m = # of faults. col = [start, end]
traj_settings.fault.faultTime = [20 30; 35 45];
% faultMagn is a m x 2 array. m = # of faults. col = [left, right]
traj_settings.fault.faultMagn = [0.5 0; 0 0.5];

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
settings.kf.forceVelErr = 1;
settings.kf.forceSysErr = 0;

% Initial Covariance
settings.cov.x = 100;
settings.cov.y = 100;
settings.cov.tht = pi/4;
settings.cov.vel = 1;
settings.cov.omg = 1;
settings.cov.imubias = 0.1;
settings.cov.scale_l = 0.0001;
settings.cov.scale_r = 0.0001;
settings.cov.scale_b = 0.0001;