function plot_rosdata_compare_error_plans( hist1, hist2, data, plotNum )
%PLOT_SIM_TIMELAPS_PLANS plots the robot timelapse for the PLANS 2014 document

ts = 340;
te = 405;

time = data.gps(:,1);
pos_gps1 = interp1(hist1.t, hist1.x(:,1:2), time);
pos_gps2 = interp1(hist2.t, hist2.x(:,1:2), time);

pos_err1 = vnorm(pos_gps1-data.gps(:,2:3),2);
pos_err2 = vnorm(pos_gps2-data.gps(:,2:3),2);

idx = ts<time & time<te;

figure(plotNum); plotNum=plotNum+1; clf; hold on;
plot(time(idx), pos_err1(idx), 'r.');
plot(time(idx), pos_err2(idx), 'b.');
% plot_robot(hist1.x, downsample, h1, radius, 'r');
% plot_robot(hist2.x, downsample, h1, radius, 'b');
title('Instantaneous Distance Between Robot State and GPS location');
xlabel('Time (s)'); ylabel('Distance (m)');
% axis square;
grid on;
legend('Odom Error Filtering', 'No Odom Error Filtering')

% legend('Truth Path', 'Estimated Path', 'True Robot Heading', 'Estimated Robot Heading')

end

