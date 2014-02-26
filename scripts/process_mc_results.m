
%% Initial practice GPS/IMU Dataset
outputfolder = 'H:\data\mower\errors';
name = 'data_02_25_2014_errors_4.mat';
filename = fullfile(outputfolder, name);

load(filename)

%% GPS/IMU Plots
% plot_montecarlo_errors(all_errors, all_settings, all_traj_settings, 9:11, 100);
plot_montecarlo_errors_3d(all_errors, all_settings, all_traj_settings, gps, imu, 9:11, 200);