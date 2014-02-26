%% Test 2:
% - GPS/ Visual Odometry
% - Scale factor errors

clearvars
addpath('..\util\progressbar');

outputfolder = 'H:\data\mower\gps_velocity';
name = 'data_02_25_2014_errors.mat';
filename = fullfile(outputfolder, name);

% sd = 100;
% sdRun = 510405;
% rng(sd);

gps.min = 0.05;
gps.max = 0.5;
gps.num = 5;
gps.val = linspace(gps.min, gps.max, gps.num)';

vel.min = 0.001;
vel.max = 0.1;
vel.num = 5;
vel.val = linspace(vel.min, vel.max, vel.num)';

% nRuns = 20;
nGPS = size(gps.val,1);
nIMU = size(vel.val,1);
nRuns = nGPS * nIMU;
nSims = 50;

%% Set up configuration
[settings, traj_settings] = config_montecarlo_test2;

% Initialize setting structures
nSims = nSims+1;
nTotal = nRuns*nSims;
all_settings = repmat(settings, nRuns, nSims);
all_traj_settings = repmat(traj_settings, nRuns, nSims);

% Add an extra simulation for default values
settings.sys.x = 0.01;
settings.sys.y = 0.01;
settings.sys.tht = 0.01;
settings.sys.vel = 0.1;
settings.sys.omg = 0.01;
settings.sys.verr_r = 0.01;
settings.sys.verr_l = 0.01;
settings.sys.imubias = 0.00005;
noise_settings(1, 1) = settings.sys;

% PreInitialize settings
noise_settings = repmat(settings.sys, nSims, 1);
for jj = 2:nSims
    sysnoise = rand(20);
    
    % System noise
%     settings.sys.x = 0.01;
%     settings.sys.y = 0.01;
%     settings.sys.tht = 0.01;
%     settings.sys.vel = 0.1;
%     settings.sys.omg = 0.01;
%     settings.sys.verr_r = 0.01;
%     settings.sys.verr_l = 0.01;
%     settings.sys.imubias = 0.00005;
    settings.sys.x = 0.001 + 0.1*sysnoise(1);
    settings.sys.y = 0.001 + 0.1*sysnoise(2);
    settings.sys.tht = 0.001 + 0.1*sysnoise(3);
    settings.sys.vel = 0.01 + 0.5*sysnoise(4);
    settings.sys.omg = 0.001 + 0.5*sysnoise(5);
    settings.sys.scale_l = 0.00001 + 0.0001*sysnoise(6);
    settings.sys.scale_r = 0.00001 + 0.0001*sysnoise(7);
    settings.sys.scale_b = 0.00001 + 0.0001*sysnoise(8);
    
    noise_settings(jj, 1) = settings.sys;
end

for i_gps = 1:nGPS
    for i_vel = 1:nIMU
        curr_run = (i_gps-1)*nIMU+i_vel;
        randvals = rand(10);
        
        % Measurement Noise Generation
        traj_settings.std.gps = gps.val(i_gps);
        traj_settings.std.velocity = vel.val(i_vel);
        %     traj_settings.std.ranger = 0.01 + 0.9*randvals(1);
        
        % Measurement Noise in Kalman Filter
        settings.std.gps = traj_settings.std.gps*2;
        settings.std.velocity = traj_settings.std.velocity*2;
        
        for jj = 1:nSims
            settings.sys = noise_settings(jj, 1);
            all_settings(curr_run, jj) = settings;
            all_traj_settings(curr_run, jj) = traj_settings;
        end
    end
end

%% Run Simulation
[hist, data, traj] = simulate_robot(all_settings(1,1), all_traj_settings(1,1));

nStates = size(traj.state, 2);
errors = struct('rms',zeros(nStates,1));

run_hist = repmat(hist, nSims, 1);
run_data = repmat(data, nSims, 1);
run_settings = repmat(settings, nSims, 1);
run_traj_settings = repmat(traj_settings, nSims, 1);
all_errors = repmat(errors, nRuns, nSims);
progressbar('Measurement Noise', 'System Noise')
for ii = 1:nRuns
    [data, ~] = generate_sensors(traj, all_traj_settings(ii,1), all_settings(ii,1));
    for jj = 1:nSims
        progressbar([],(jj-1)/nSims);
        [curr_hist, curr_data, ~] = simulate_robot(all_settings(ii,jj), all_traj_settings(ii,jj), traj, data);
%         run_hist(jj) = curr_hist;
%         run_data(jj) = curr_data;
%         run_settings(jj) = all_settings(ii, jj);
%         run_traj_settings(jj) = all_traj_settings(ii, jj);
        errors.rms = getRMSErrors(curr_hist, traj);
        all_errors(ii,jj) = errors;
        progressbar([],jj/nSims);
    end
    progressbar(ii/nRuns,[]);
    curr_run = ii;
%     save(getValidFilename(filename),'run_hist','run_data','run_settings','run_traj_settings','traj','curr_run');
end

%% Save off data
% save(getValidFilename('mc_output_2_20_2014'),'all_hist','all_data','all_settings','all_traj_settings','traj');
save(getValidFilename(filename),'all_errors','all_traj_settings','all_settings', 'gps', 'vel');

%% Plots
% plot_montecarlo_errors(all_errors, all_settings, all_traj_settings, [9, 10, 11], 100);
%%
plot_montecarlo_errors_3d_test2(all_errors, all_settings, all_traj_settings, gps, vel, [9:11], 200);
% plot_montecarlo_results(all_hist, all_data, traj, settings, nRuns, nSims, 20);
% plot_simulation_data(data, traj, 1);
% plot_simulation_results( hist, traj, settings, 100 );