function [ ] = plot_montecarlo_errors_3d( all_errors, all_settings, all_traj_settings, x, y, plotStates, plotNum)

[nRuns, nSims] = size(all_settings);
nStates = size(all_errors(1,1).rms, 1);

% plotStates = [9, 10, 11];
nPlots = length(plotStates);
names = getNames();

values_to_store = 1:max(min(5,nSims-2),1);

nX = length(x.val);
nY = length(y.val);

rms_mean = zeros(nX, nY, nStates);
ii = 1;
for ix=1:nX
    for iy=1:nY
%         meas_std = all_traj_settings(ii,1).std;
        
        rms = zeros(nStates, nSims);
        for jj=1:nSims
            rms(:,jj) = all_errors(ii,jj).rms;
        end
        
        for jj=1:nStates
            rms_sort = sort(rms(jj,:));
            rms_mean(ix, iy, jj) = mean(rms_sort(values_to_store));
        end
        
        ii=ii+1;
    end
end


%     figure(plotNum); plotNum = plotNum+1; clf; hold on;
    figure(plotNum); plotNum = plotNum+1; clf;
for kk=1:nPlots
    state = plotStates(kk);
        subplot(1, nPlots, kk);
%     stem3(x.val, y.val, squeeze(rms_mean(:, :, state)));
    bar3(squeeze(rms_mean(:, :, state)));
    set(gca(gcf), 'xticklabel', x.val, 'yticklabel', y.val)
    title(['Monte-Carlo Results: ' names{state}]);
    xlabel('Simulated GPS \sigma');
    ylabel('Simulated Gyro \sigma');
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