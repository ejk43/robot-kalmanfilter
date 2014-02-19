%% Simulation (Wheel Error Only)

clearvars

%% Set up configuration
[settings, traj_settings] = config_sim_systemerr_wheelerr;

%% Run Simulation
[hist, data, traj] = simulate_robot(settings, traj_settings);

%% Plots
plot_simulation_data(data, traj, 1);
plot_simulation_results( hist, traj, settings, 100 );

%% Specific plots (for ION PLANS 2014)
plot_sim_timelapse_plans(hist, traj, data, 200);
plot_sim_figures_plans(hist, traj, 200);
