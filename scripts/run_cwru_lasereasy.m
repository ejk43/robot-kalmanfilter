%% Simulation (Wheel Error Only)

clearvars

%% Set up configuration
% [settings] = config_rosdata_wheelerror_only;
[settings] = config_rosdata_systemerr_wheelerr;

%% Set the data file, time, and GPS setting
settings.data.name = 'LaserTest_EasyDrive_2';
settings.data.Ts = -1; % Start Time
settings.data.Te = -1; % End Time
settings.robot.off_gps = [-0.45; 0]; % GPS offset in body frame
% settings.robot.tpm_right = 26500; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 27150; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.55; % Track Width
% settings.robot.tpm_right = 26500*0.9; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 27150*0.91; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.55*1.05; % Track Width
% settings.robot.tpm_right = 26500*0.96*0.99; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 27150*0.95*0.99; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.55*1.02*1.01; % Track Width
settings.robot.tpm_right = 25190; % Ticks per meter, Right Wheel
settings.robot.tpm_left= 25530; % Ticks per meter, Left Wheel
settings.robot.track_m = 0.57; % Track Width

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