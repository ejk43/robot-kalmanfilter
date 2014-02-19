function [settings] = config_rosdata_systemerr_wheelerr
% Simulation: Wheel Errors Only
% Set up the settings for a simulation trajectory with wheel errors

addpath('./../estimation');

%% Populate Kalman Filter settings
settings = set_defaults();


% KF Settings
settings.kf.useGPS = 1;
settings.kf.useIMU = 1;
settings.kf.useOdom = 1;
settings.kf.useWheelError = 1;
settings.kf.useSystemParams = 1;
settings.kf.useRanger = 0;

settings.kf.forceSysErr = 1;
settings.kf.forceVelErr = 1;
% settings.kf.forceVelErrTime = [0 1000];
% settings.kf.forceSysErrTime = [0 0];

% System Noise
settings.sys.x = 0.01;
settings.sys.y = 0.01;
settings.sys.tht = 0.01;
settings.sys.vel = 0.1;
settings.sys.omg = 0.01;
settings.sys.verr_r = 0.0005;
settings.sys.verr_l = 0.0005;
settings.sys.imubias = 0.00005;
settings.sys.scale_l = 0.0000001;
settings.sys.scale_r = 0.0000001;
settings.sys.scale_b = 0.0000001;

% Measurement Noise
settings.std.gps = 0.05;
settings.std.imu = 0.01;
settings.std.enc_eps = 0.005;
settings.std.enc_alp = 0.01;

% Initial Covariance
settings.cov.x = 100;
settings.cov.y = 100;
settings.cov.tht = pi;
settings.cov.vel = 1;
settings.cov.omg = 1;
settings.cov.imubias = 0.1;
settings.cov.verr_r = 0.0001;
settings.cov.verr_l = 0.0001;
settings.cov.scale_l = 0.00001;
settings.cov.scale_r = 0.00001;
settings.cov.scale_b = 0.00001;