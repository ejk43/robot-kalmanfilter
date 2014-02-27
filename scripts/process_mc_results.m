
%% Initial practice GPS/IMU Dataset
outputfolder = 'H:\data\mower\errors';
name = 'data_02_25_2014_errors_4.mat';
filename = fullfile(outputfolder, name);
load(filename)
measurement_names = {'GPS', 'Gyro'};
plot_montecarlo_errors_3d(all_errors, all_settings, all_traj_settings, gps, imu, [9:11], measurement_names, 200);

%% GPS/IMU Dataset that looks good
outputfolder = 'H:\data\mower\errors';
name = 'data_02_25_2014_errors_5.mat';
filename = fullfile(outputfolder, name);
load(filename)
measurement_names = {'GPS', 'Gyro'};
plot_montecarlo_errors_3d_combine(all_errors, all_settings, all_traj_settings, gps, imu, [9:11], measurement_names, 200);


%% GPS/Visual Odometry Dataset that looks good
outputfolder = 'H:\data\mower\gps_velocity';
name = 'data_02_25_2014_errors_3.mat';
filename = fullfile(outputfolder, name);
load(filename)
measurement_names = {'GPS', 'Velocity'};
plot_montecarlo_errors_3d_combine(all_errors, all_settings, all_traj_settings, gps, vel, [9:11], measurement_names, 200);


%% Ranger/IMU Dataset that looks good
outputfolder = 'H:\data\mower\ranger_imu';
name = 'data_02_25_2014_errors.mat';
filename = fullfile(outputfolder, name);
load(filename)
measurement_names = {'Range', 'Gyro'};
plot_montecarlo_errors_3d_combine(all_errors, all_settings, all_traj_settings, ranger, imu, [9:11], measurement_names, 200);

