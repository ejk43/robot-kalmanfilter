function [ ] = plot_montecarlo_errors_3d( all_errors, all_settings, all_traj_settings, gps, imu, plotStates, names_meas, plotNum)

[nRuns, nSims] = size(all_settings);
nStates = size(all_errors(1,1).rms, 1);

% plotStates = [9, 10, 11];
nPlots = length(plotStates);
names = getNames();

values_to_store = 1:max(min(15,nSims-2),1);

nX = length(gps.val);
nY = length(imu.val);

rms_best = zeros(nX, nY, nStates);
rms_median = zeros(nX, nY, nStates);
ii = 1;
for ix=1:nX
    for iy=1:nY
%         meas_std = all_traj_settings(ii,1).std;
        
        rms = zeros(nStates, nSims);
        for jj=1:nSims
            rms(:,jj) = all_errors(ii,jj).rms;
        end
        
        rms_median(ix, iy, :) = median(rms,2);
        
        for jj=1:nStates
            rms_sort = sort(rms(jj,:));
            rms_best(ix, iy, jj) = mean(rms_sort(values_to_store));
        end
        
        ii=ii+1;
    end
end


%     figure(plotNum); plotNum = plotNum+1; clf; hold on;
figure(plotNum); plotNum = plotNum+1; clf;
subplot(1, 2, 1);
bar3((rms_best(:,:,9) + rms_best(:,:,10))./2);
set(gca(gcf), 'xticklabel', gps.val, 'yticklabel', imu.val)
title(['Monte-Carlo Results: Ticks Per Meter (Mean of Left/Right Wheel)']);
xlabel(['Simulated ' names_meas{1} ' \sigma']);
ylabel(['Simulated ' names_meas{2} ' \sigma']);
zlim([0 0.1])

subplot(1, 2, 2);
bar3(rms_best(:,:,11));
set(gca(gcf), 'xticklabel', gps.val, 'yticklabel', imu.val)
title(['Monte-Carlo Results: ' names{11}]);
xlabel(['Simulated ' names_meas{1} ' \sigma']);
ylabel(['Simulated ' names_meas{2} ' \sigma']);
zlim([0 0.1])
    

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