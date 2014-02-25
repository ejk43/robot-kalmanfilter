function [ ] = plot_montecarlo_folder( folder, plotNum)

files = dir([folder '\*.mat']);
nFiles = size(files,1);

names = getNames();

for ii = 1:nFiles
    load(fullfile(folder, files(ii).name));
    curr_run
    gpsnoise = run_traj_settings(1).std.gps
    imunoise = run_traj_settings(1).std.imu
    
    figure(plotNum); plotNum=plotNum+1;
    
    state = 9;
    subplot(3,1,1);
    plot_montecarlo_state( run_hist, traj, state );
    title([names{state} ' Error, GPS \sigma =  ' num2str(gpsnoise) ', IMU \sigma = ' num2str(imunoise)]);
    xlabel('Time (s)');
    ylabel('Error')
    
    state = 10;
    subplot(3,1,2);
    plot_montecarlo_state( run_hist, traj, state );
    title([names{state} ' Error, GPS \sigma =  ' num2str(gpsnoise) ', IMU \sigma = ' num2str(imunoise)]);
    xlabel('Time (s)');
    ylabel('Error')
    
    state = 11;
    subplot(3,1,3);
    plot_montecarlo_state( run_hist, traj, state );
    title([names{state} ' Error, GPS \sigma =  ' num2str(gpsnoise) ', IMU \sigma = ' num2str(imunoise)]);
    xlabel('Time (s)');
    ylabel('Error')
end

end

function names = getNames()

names = {'X Position';
    'Y Position';
    'Heading';
    'Forward Velocity';
    'Angular Velocity';
    'IMU Bias'};

names = [names;
    {'Velocity Error (Left Wheel)'};
    {'Velocity Error (Right Wheel)'}];


names = [names;
    {'Ticks-Per-Meter Scaling (Left Wheel)'};
    {'Ticks-Per-Meter Scaling (Right Wheel)'};
    {'Track Width Scaling'}];

end
