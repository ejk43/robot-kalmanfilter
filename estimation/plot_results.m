
names = {'X Position';
         'Y Position';
         'Heading';
         'Forward Velocity';
         'Angular Velocity';
         'Velocity Error (Right Wheel)';
         'Velocity Error (Left Wheel)'};
    

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