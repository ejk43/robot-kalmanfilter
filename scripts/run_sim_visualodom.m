%% Simulation (Wheel Error Only)

clearvars

%% Set up configuration
[settings, traj_settings] = config_sim_visualodom;

%% Run Simulation
[hist, data, traj] = simulate_robot(settings, traj_settings);

%% Plots
plot_simulation_data(data, traj, 1);
plot_simulation_results( hist, traj, settings, 100 );