function [hist, data, traj, settings, traj_settings] = simulate_robot(settings, traj_settings, traj, data)

%% Populate settings
if nargin < 1
    settings = set_defaults;
end
if nargin < 2
    traj_settings = set_trajectory;
end

%% Generate the Trajectory
if nargin < 3
    traj = generate_trajectory(traj_settings);
end

%% Generate Sensor Data
if nargin < 4
    [data, traj] = generate_sensors(traj, traj_settings, settings);
end

%% Run sensor data through filter
hist = process_robot_data(settings, data);