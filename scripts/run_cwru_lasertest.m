%% Simulation (Wheel Error Only)

clearvars

%% Set up configuration
% [settings] = config_rosdata_wheelerror_only;
[settings] = config_rosdata_systemerr_wheelerr;

%% Set the data file, time, and GPS setting
settings.data.name = 'LaserTest_Drive';
settings.data.Ts = 35; % Start Time
settings.data.Te = 1000; % End Time
settings.robot.off_gps = [-0.45; 0]; % GPS offset in body frame

%% Set the filter coercing
settings.kf.forceVelErrTime = [0 60];
settings.kf.forceSysErrTime = [60 1000];

%% Run Simulation
[ hist, data ] = process_robot_data(settings);

%% Plots
plot_results