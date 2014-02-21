%% Simulation (Wheel Error Only)

addpath('..\util\progressbar');

clearvars
sd = 10;
rng(sd);

gps.min = 0.01;
gps.max = 0.9;
gps.num = 10;
gps.val = linspace(gps.min, gps.max, gps.num)';

imu.min = 0.002;
imu.max = 0.5;
imu.num = 5;
imu.val = linspace(imu.min, imu.max, imu.num)';

% nRuns = 20;
nGPS = size(gps.val,1);
nIMU = size(imu.val,1);
nRuns =  nGPS * nIMU;
nSims = 50;

%% Set up configuration
[settings, traj_settings] = config_montecarlo_systemerror_only;

nTotal = nRuns*nSims;
all_settings = repmat(settings, nTotal, 1);
all_traj_settings = repmat(traj_settings, nTotal, 1);

sysnoise = rand(20);
for i_gps = 1:nGPS
    for i_imu = 1:nIMU
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
            
            % System Noise
            settings.sys.x = 0.001 + 0.1*sysnoise(1);
            settings.sys.y = 0.001 + 0.1*sysnoise(2);
            settings.sys.tht = 0.001 + 0.1*sysnoise(3);
            settings.sys.vel = 0.01 + 0.5*sysnoise(4);
            settings.sys.omg = 0.001 + 0.5*sysnoise(5);
            settings.sys.scale_l = 0.00005 + 0.01*sysnoise(6);
            settings.sys.scale_r = 0.00005 + 0.01*sysnoise(7);
            settings.sys.scale_b = 0.00005 + 0.01*sysnoise(8);
            
            idx = (i_gps*i_imu-1)*nSims+jj;
            all_settings(idx, 1) = settings;
            all_traj_settings(idx, 1) = traj_settings;
        end
    end
end

%% Run Simulation
[hist, data, traj] = simulate_robot(all_settings(1), all_traj_settings(1));

all_hist = repmat(hist, nTotal, 1);
all_data = repmat(data, nTotal, 1);
progressbar('Measurement Noise', 'System Noise')
for ii = 1:nRuns
    for jj = 1:nSims
        idx = (ii-1)*nSims+jj;
        [all_hist(idx), all_data(idx), ~] = simulate_robot(all_settings(idx), all_traj_settings(idx), traj);
        progressbar([],jj/nSims);
    end
    progressbar(ii/nRuns,[]);
end

%% Save off data
save(getValidFilename('mc_output_2_20_2014'),'all_hist','all_data','all_settings','all_traj_settings','traj');

%% Plots
plot_montecarlo_results(all_hist, all_data, traj, settings, nRuns, nSims, 20);
% plot_simulation_data(data, traj, 1);
% plot_simulation_results( hist, traj, settings, 100 );