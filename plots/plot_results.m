
names = {'X Position';
         'Y Position';
         'Heading';
         'Forward Velocity';
         'Angular Velocity';
         'IMU Bias';
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

%% Filtered Heading vs Point-by-Point Heading

x_smooth = smooth(data.gps(:,1),data.gps(:,2));
y_smooth = smooth(data.gps(:,1),data.gps(:,3));
gps_smooth = [x_smooth y_smooth];
coord_diff = diff(data.gps(:,2:3));
coord_diff_smooth = diff(gps_smooth);
heading_ptbypt = atan2(coord_diff(:,2), coord_diff(:,1));
heading_ptbypt_smooth = atan2(coord_diff_smooth(:,2), coord_diff_smooth(:,1));

plotNum = 20;
figure(plotNum); plotNum=plotNum+1; clf; hold on;
plot(hist.t(2:end),[heading_ptbypt heading_ptbypt_smooth],'x');
plot(hist.t,wrap(hist.x(:,3),2*pi),'r-x');


figure(plotNum); plotNum = plotNum + 1;
subplot(2,1,1);
plot(data.gps(:,2:3),'x-');
subplot(2,1,2);
plot([x_smooth y_smooth],'x-');

