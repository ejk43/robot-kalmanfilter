%% Simulation (Wheel Error Only)

clearvars

%% Set up configuration
% [settings] = config_rosdata_wheelerror_only;
[settings] = config_rosdata_systemerr_wheelerr;

%% Set the data file, time, and GPS setting
% settings.data.name = 'Competition_Sunday_Run1';
settings.data.name = 'Competition_Saturday';
settings.data.Ts = 330; % Start Time
settings.data.Te = 410; % End Time
% settings.data.Ts = 105; % Start Time
% settings.data.Te = 1000; % End Time
settings.robot.off_gps = [0.0; 0]; % GPS offset in body frame
% settings.robot.tpm_right = 26500; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 27150; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.55; % Track Width
% settings.robot.tpm_right = 26500*0.9; % Ticks per meter, Right Wheel
% settings.robot.tpm_left= 27150*0.91; % Ticks per meter, Left Wheel
% settings.robot.track_m = 0.55*1.05; % Track Width
settings.robot.tpm_right = 25190; % Ticks per meter, Right Wheel
settings.robot.tpm_left= 25530; % Ticks per meter, Left Wheel
settings.robot.track_m = 0.57; % Track Width

% EKF tunings
settings.sys.x = 0.01;
settings.sys.y = 0.01;
settings.sys.tht = 0.01;
settings.init.tht = 0;
settings.sys.vel = 0.1;
settings.sys.omg = 0.02;
settings.sys.verr_r = 0.01;
settings.sys.verr_l = 0.01;
settings.std.gps = 0.1;
settings.std.imu = 0.01;
settings.std.enc_eps = 0.0001;
settings.std.enc_alp = 0.0001;

%% Set the filter coercing
% settings.kf.forceVelErrTime = [0 1000];
% settings.kf.forceSysErrTime = [0 0];
settings.kf.forceVelErrTime = [0 0];
settings.kf.forceSysErrTime = [0 1000];

%% Run Simulation
settings.kf.useWheelError = 1;
settings.kf.useSystemParams = 1;
[ hist1, data ] = process_robot_data(settings);


%% Run Simulation
settings.kf.useWheelError = 0;
settings.kf.useSystemParams = 0;
[ hist2, data ] = process_robot_data(settings);

%% Plots
plot_data_figures_plans(hist1, 200);
figure(300); clf;
plot_rosdata_timelapse_plans( hist1, hist2, data, 300)
%%
plot_rosdata_compare_error_plans( hist1, hist2, data, 400 )
%%
hist = hist1;
plot_results
%%
%%
%%
hist=hist2;