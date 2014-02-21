%% Simulation (Wheel Error Only)

clearvars

%% Set up configuration
% [settings] = config_rosdata_wheelerror_only;
[settings] = config_rosdata_systemerr_wheelerr;

%% Set the data file, time, and GPS setting
settings.data.name = 'LaserTest_EasyDrive_2';
settings.data.Ts = 10; % Start Time
settings.data.Te = 100; % End Time
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
% settings.robot.tpm_right = 25190*1.2; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 25530*0.9; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.57*1.1; % Track Width
% settings.robot.tpm_right = 24940*1.2; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 25280*0.9; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.57*1.1; % Track Width

settings.sys.scale_l = 0.000001;
settings.sys.scale_r = 0.000001;
settings.sys.scale_b = 0.000001;
% EKF tunings
% settings.sys.x = 0.01;
% settings.sys.y = 0.01;
% settings.sys.tht = 0.01;
% settings.init.tht = 0;
% settings.sys.vel = 0.1;
% settings.sys.omg = 0.02;
% settings.sys.verr_r = 0.01;
% settings.sys.verr_l = 0.01;
% settings.std.gps = 0.1;
% settings.std.imu = 0.01;
% settings.std.enc_eps = 0.0001;
% settings.std.enc_alp = 0.0001;

%% Set the filter coercing
% settings.kf.forceVelErrTime = [0 1000];
% settings.kf.forceSysErrTime = [0 0];
settings.kf.forceVelErrTime = [0 40];
settings.kf.forceSysErrTime = [0 1000];

%% Run Simulation
[ hist, data ] = process_robot_data(settings);

%% Plots
plot_results
%%
plot_data_figures_plans(hist, 200);
plot_data_odomerrs_plans(hist, 210);
%%
plot_timelapse_plans( hist, data, 230)