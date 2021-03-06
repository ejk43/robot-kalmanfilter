
%% Plot State Information

plot_rawdata_results( hist, settings, 1 )

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
plot(data.gps(2:end,1),[heading_ptbypt heading_ptbypt_smooth],'x');
plot(hist.t,wrap(hist.x(:,3),2*pi),'r-x');


figure(plotNum); plotNum = plotNum + 1;
subplot(2,1,1);
plot(data.gps(:,2:3),'x-');
subplot(2,1,2);
plot([x_smooth y_smooth],'x-');


%% Compare Filtered Angular Velocity to IMU Angular Velocity

imu_correction = interp1(hist.t, hist.x(:,6), data.imu(:,1));

plotNum = 30;
figure(plotNum); clf; 
subplot(2,1,1); hold on;
x = hist.x(:,5);
x_err = 3*sqrt(hist.P(:,5,5));
x_rts = hist.x_rts(:,5);
x_rts_err = 3*sqrt(hist.P_rts(:,5,5));
plot(hist.t, x, 'b');
plot(hist.t, x_rts, 'g');
plot(data.imu(:,1), data.imu(:,2) + imu_correction, 'rx');
plot(hist.t, x+x_err, 'b:', hist.t, x-x_err, 'b:');
plot(hist.t, x_rts+x_rts_err, 'g:', hist.t, x_rts-x_rts_err, 'g:');
legend('State', 'RTS-smoothed', 'Corrected IMU');
title('Filtered Angular Velocity vs Corrected IMU');
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
subplot(2,1,2); hold on;
plot(data.imu(:,1), data.imu(:,2), 'bx');
plot(data.imu(:,1), data.imu(:,2) + imu_correction, 'rx');
legend('Raw IMU', 'Corrected IMU');
title('Raw IMU vs Corrected IMU');
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');

%% Stuff
figure(40);
px(1) = subplot(3,1,1); 
plot(data.odom(:,1),data.odom(:,2),'.'); 
title('Right Vel')
px(2) = subplot(3,1,2); 
plot(data.odom(:,1),data.odom(:,3),'.'); 
title('Left Vel')
px(3) = subplot(3,1,3); 
plot(hist.t, hist.x(:,3),'.'); 
title('Heading (rad)');
linkaxes(px,'x')


