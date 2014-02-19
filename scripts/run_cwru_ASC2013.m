%% Simulation (Wheel Error Only)

clearvars

%% Set up configuration
% [settings] = config_rosdata_wheelerror_only;
[settings] = config_rosdata_systemerr_wheelerr;

%% Set the data file, time, and GPS setting
% settings.data.name = 'Competition_Sunday_Run1';
settings.data.name = 'Competition_Saturday';
settings.data.Ts = 340; % Start Time
settings.data.Te = 410; % End Time
% settings.data.Ts = 105; % Start Time
% settings.data.Te = 1000; % End Time
settings.robot.off_gps = [-0.45; 0]; % GPS offset in body frame
settings.robot.tpm_right = 26500; % Ticks per meter, Right Wheel
settings.robot.tpm_left= 27150; % Ticks per meter, Left Wheel
settings.robot.track_m = 0.55; % Track Width
% settings.robot.tpm_right = 26500*0.9; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 27150*0.91; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.55*1.05; % Track Width
% settings.robot.tpm_right = 26500*0.96*0.99; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 27150*0.95*0.99; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.55*1.02*1.01; % Track Width

% EKF tunings
settings.init.tht = 0;
settings.sys.vel = 0.1;
settings.sys.omg = 0.02;
settings.sys.verr_r = 0.01;
settings.sys.verr_l = 0.01;
settings.std.gps = 0.05;
settings.std.imu = 0.001;
settings.std.enc_eps = 0.005;
settings.std.enc_alp = 0.01;

%% Set the filter coercing
% settings.kf.forceVelErrTime = [0 1000];
% settings.kf.forceSysErrTime = [0 0];
settings.kf.forceVelErrTime = [0 0];
settings.kf.forceSysErrTime = [0 1000];

%% Run Simulation
[ hist, data ] = process_robot_data(settings);

%% Plots
plot_results
plot_data_figures_plans(hist, 200);