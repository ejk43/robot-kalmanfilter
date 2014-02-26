function [ ] = plot_montecarlo_errors( all_errors, all_settings, all_traj_settings, plotStates, plotNum)

[nRuns, nSims] = size(all_settings);
nStates = size(all_errors(1,1).rms, 1);

plotStates = [9, 10, 11];
nPlots = length(plotStates);
names = getNames();

for ii=1:nRuns    
    meas_std = all_traj_settings(ii,1).std; 
    
    rms = zeros(nStates, nSims); 
    for jj=1:nSims
        rms(:,jj) = all_errors(ii,jj).rms;
    end
    
    
    figure(plotNum); plotNum = plotNum+1;
    for kk=1:nPlots
        state = plotStates(kk);
        subplot(nPlots, 1, kk);
        hist(rms(state, :));
        xlabel('RMS State Errors During Monte Carlo Runs');
        title([names{state} ', GPS \sigma: ' num2str(meas_std.gps) ' Gyro \sigma: ' num2str(meas_std.imu)]);
    end
    
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