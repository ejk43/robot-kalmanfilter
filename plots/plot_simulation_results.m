function [ ] = plot_simulation_results( hist, traj, plotNum )
%Plots the simulation results

if nargin<3
    plotNum = 1;
end

names = {'X Position';
    'Y Position';
    'Heading';
    'Forward Velocity';
    'Angular Velocity';
    'IMU Bias';
    'Velocity Error (Left Wheel)';
    'Velocity Error (Right Wheel)'};

% Put the true state into timestamps of the filtered data
state_true = interp1(traj.t, traj.state, hist.t);

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
    if ii <= size(traj.state, 2)
        plot(traj.t, traj.state(:,ii), 'r-');
    end
    title([names{ii}]);
    xlabel('Time (s)'); ylabel('State');
    
    px(2) = subplot(2,1,2); hold on
    err = state_true(:,ii) - x;
    err_rts = state_true(:,ii) - x_rts;
    plot(hist.t, err, 'b', hist.t, err+x_err, 'b:', hist.t, err-x_err, 'b:');
    plot(hist.t, err_rts, 'g', hist.t, err_rts+x_rts_err, 'g:', hist.t, err_rts-x_rts_err, 'g:');
    xlabel('Time (s)'); ylabel('Error');
    title([names{ii} ' Error']);
end


end

