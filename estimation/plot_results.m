
names = {'X Position';
         'Y Position';
         'Heading';
         'Forward Velocity';
         'Angular Velocity';
         'Velocity Error (Right Wheel)';
         'Velocity Error (Left Wheel)'};
    

plotNum = 1;
for ii = 1:size(hist.x,2)
    figure(plotNum+ii);
    x = hist.x(:,ii);
    x_var = hist.P(:,ii,ii);
    x_err = 3*sqrt(x_var);
    plot(hist.t, x, 'b', hist.t, x+x_err, 'r:', hist.t, x-x_err, 'r:');
    title([names{ii}]);
    xlabel('Time (s)');
    ylabel('State');
    
end