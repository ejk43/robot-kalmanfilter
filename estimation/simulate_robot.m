
clearvars;

%% Populate settings
settings = set_defaults;
traj_settings = set_trajectory;


%% Generate the Trajectory
traj = generate_trajectory(traj_settings);

%% Generate Sensor Data
data = generate_sensors(traj, traj_settings);

%% Run sensor data through filter
hist = process_robot_data(settings, data);

%% Compare estimated state with true state