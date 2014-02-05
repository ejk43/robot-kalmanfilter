function [ ] = plot_rawdata_results( hist, settings, plotNum )
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

plotNum = 1;
for ii = 1:size(hist.x,2)
    figure(plotNum+ii); clf; hold on;
    x = hist.x(:,ii);
    x_err = 3*sqrt(hist.P(:,ii,ii));
    x_rts = hist.x_rts(:,ii);
    x_rts_err = 3*sqrt(hist.P_rts(:,ii,ii));
    plot(hist.t, x, 'b', hist.t, x+x_err, 'b:', hist.t, x-x_err, 'b:');
    plot(hist.t, x_rts, 'g', hist.t, x_rts+x_rts_err, 'g:', hist.t, x_rts-x_rts_err, 'g:');
    title([names{ii}]);
    xlabel('Time (s)');
    ylabel('State');
end


end

