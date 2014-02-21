function [ ] = plot_montecarlo_results( all_hist, all_data, traj, settings, nRuns, nSims, plotNum )
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

for ii = 1:nRuns
    hist_idx = (ii-1)*nSims+1 : ((ii-1)*nSims+nSims);
    
    state = 9;
    plot_montecarlo_state( all_hist(hist_idx), traj, state, plotNum );
    plotNum = plotNum + 1;
    title([names{state} ' Error, Measurement Settings ' num2str(ii)]);
    xlabel('Time (s)');
    ylabel('Scale Factor Error from Truth')
    
    state = 10;
    plot_montecarlo_state( all_hist(hist_idx), traj, state, plotNum );
    plotNum = plotNum + 1;
    title([names{state} ' Error, Measurement Settings ' num2str(ii)]);
    xlabel('Time (s)');
    ylabel('Scale Factor Error from Truth')
    
    state = 11;
    plot_montecarlo_state( all_hist(hist_idx), traj, state, plotNum );
    plotNum = plotNum + 1;
    title([names{state} ' Error, Measurement Settings ' num2str(ii)]);
    xlabel('Time (s)');
    ylabel('Scale Factor Error from Truth')

end



end

