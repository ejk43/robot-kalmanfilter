
clearvars;
addpath('../estimation');

%% Populate settings
settings = set_defaults;
traj_settings = set_trajectory;

[hist, data, traj] = simulate_robot(settings, traj_settings);

%% Plots

plot_simulation_data(data, traj, 1);
plot_simulation_results( hist, traj, settings, 100 )