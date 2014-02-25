%% Simulation (Wheel Error Only)
clearvars
addpath('..\util\progressbar');

outputfolder = 'H:\data\mower\gps_imu';
name = 'data_02_24_2014.mat';
filename = fullfile(outputfolder, name);

sd = 10;
% sdRun = 510405;
rng(sd);

gps.min = 0.01;
gps.max = 1.0;
gps.num = 5;
gps.val = linspace(gps.min, gps.max, gps.num)';

imu.min = 0.002;
imu.max = 0.5;
imu.num = 5;
imu.val = linspace(imu.min, imu.max, imu.num)';

% nRuns = 20;
nGPS = size(gps.val,1);
nIMU = size(imu.val,1);
nRuns =  nGPS * nIMU;
nSims = 30;

%% Set up configuration
[settings, traj_settings] = config_montecarlo_systemerror_only;

nTotal = nRuns*nSims;
all_settings = repmat(settings, nRuns, nSims);
all_traj_settings = repmat(traj_settings, nRuns, nSims);

% PreInitialize settings
noise_settings = repmat(settings.sys, nSims, 1);
for jj = 1:nSims
    sysnoise = rand(20);
    
    % System noise
    settings.sys.x = 0.001 + 0.1*sysnoise(1);
    settings.sys.y = 0.001 + 0.1*sysnoise(2);
    settings.sys.tht = 0.001 + 0.1*sysnoise(3);
    settings.sys.vel = 0.01 + 0.5*sysnoise(4);
    settings.sys.omg = 0.001 + 0.5*sysnoise(5);
    settings.sys.scale_l = 0.00005 + 0.01*sysnoise(6);
    settings.sys.scale_r = 0.00005 + 0.01*sysnoise(7);
    settings.sys.scale_b = 0.00005 + 0.01*sysnoise(8);
    
    noise_settings(jj, 1) = settings.sys;
end

for i_gps = 1:nGPS
    for i_imu = 1:nIMU
        curr_run = (i_gps-1)*nIMU+i_imu;
        randvals = rand(10);
        
        % Measurement Noise Generation
%         traj_settings.std.gps = 0.01 + 0.9*randvals(ii);
%         traj_settings.std.imu = 0.002 + 0.5*randvals(ii);
        traj_settings.std.gps = gps.val(i_gps);
        traj_settings.std.imu = imu.val(i_imu);
        %     traj_settings.std.ranger = 0.01 + 0.9*randvals(1);
        
        % Measurement Noise in Kalman Filter
        settings.std.gps = traj_settings.std.gps;
        settings.std.imu = traj_settings.std.imu;
        settings.std.imu = traj_settings.std.ranger;
        
        for jj = 1:nSims
            settings.sys = noise_settings(jj, 1);
            all_settings(curr_run, jj) = settings;
            all_traj_settings(curr_run, jj) = traj_settings;
        end
    end
end

%% Run Simulation
[hist, data, traj] = simulate_robot(all_settings(1,1), all_traj_settings(1,1));

run_hist = repmat(hist, nSims, 1);
run_data = repmat(data, nSims, 1);
run_settings = repmat(settings, nSims, 1);
run_traj_settings = repmat(traj_settings, nSims, 1);
progressbar('Measurement Noise', 'System Noise')
for ii = 1:nRuns
    [data, ~] = generate_sensors(traj, all_traj_settings(ii,1), all_settings(ii,1));
    for jj = 1:nSims
        idx = (ii-1)*nSims+jj;
        [run_hist(jj), run_data(jj), ~] = simulate_robot(all_settings(idx), all_traj_settings(idx), traj, data);
        run_settings(jj) = all_settings(ii, jj);
        run_traj_settings(jj) = all_traj_settings(ii, jj);
        progressbar([],jj/nSims);
    end
    progressbar(ii/nRuns,[]);
    curr_run = ii;
    save(getValidFilename(filename),'run_hist','run_data','run_settings','run_traj_settings','traj','curr_run');
end

%% Save off data
% save(getValidFilename('mc_output_2_20_2014'),'all_hist','all_data','all_settings','all_traj_settings','traj');

%% Plots
plot_montecarlo_folder(outputfolder, 50);
% plot_montecarlo_results(all_hist, all_data, traj, settings, nRuns, nSims, 20);
% plot_simulation_data(data, traj, 1);
% plot_simulation_results( hist, traj, settings, 100 );