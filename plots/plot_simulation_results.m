function [ ] = plot_simulation_results( hist, traj, settings, plotNum )
%Plots the simulation results

if nargin<3
    plotNum = 1;
end


names = {'X Position';
    'Y Position';
    'Heading';
    'Forward Velocity';
    'Angular Velocity';
    'IMU Bias'};

if settings.kf.useWheelError
    names = [names;
        {'Velocity Error (Left Wheel)'};
        {'Velocity Error (Right Wheel)'}];
end

if settings.kf.useSystemParams
    names = [names;
        {'Ticks-Per-Meter Scaling (Left Wheel)'};
        {'Ticks-Per-Meter Scaling (Right Wheel)'};
        {'Track Width Scaling'}];
end

% Put the true state into timestamps of the filtered data
state_true = interp1(traj.t, traj.x, hist.t);

px = [];
for ii = 1:size(hist.x,2)
    x = hist.x(:,ii);
    x_err = 3*sqrt(hist.P(:,ii,ii));
    x_rts = hist.x_rts(:,ii);
    x_rts_err = 3*sqrt(hist.P_rts(:,ii,ii));
    
    figure(plotNum+ii-1); clf;
    px(1) = subplot(2,1,1); hold on;
    plot(hist.t, x, 'b', hist.t, x+x_err, 'b:', hist.t, x-x_err, 'b:');
    plot(hist.t, x_rts, 'g', hist.t, x_rts+x_rts_err, 'g:', hist.t, x_rts-x_rts_err, 'g:');
    plot(hist.t, state_true(:,ii), 'r');
    title([names{ii}]);
    xlabel('Time (s)'); ylabel('State');
    
    px(2) = subplot(2,1,2); hold on
    err = state_true(:,ii) - x;
    err_rts = state_true(:,ii) - x_rts;
    plot(hist.t, err, 'b', hist.t, x_err, 'b:', hist.t, -x_err, 'b:');
    plot(hist.t, err_rts, 'g', hist.t, x_rts_err, 'g:', hist.t, -x_rts_err, 'g:');
    xlabel('Time (s)'); ylabel('Error');
    title([names{ii} ' Error']);
    
    linkaxes(px,'x');
end


end

