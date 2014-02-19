function plot_rosdata_timelapse_plans( hist1, hist2, data, plotNum )
%PLOT_SIM_TIMELAPS_PLANS plots the robot timelapse for the PLANS 2014 document

downsample = 500;

radius = 0.2;

h1 = figure(plotNum); hold on;
plot(hist1.x(10:end-10,1),hist1.x(10:end-10,2), 'r.');
plot(hist2.x(10:end-10,1),hist2.x(10:end-10,2), 'b.');
plot(data.gps(10:end-10,2),data.gps(10:end-10,3), 'k.');
% plot_robot(hist1.x, downsample, h1, radius, 'r');
% plot_robot(hist2.x, downsample, h1, radius, 'b');
title('X,Y Location (Forward Pass)');
xlabel('X (m)'); ylabel('Y (m)');
axis square;
grid on;

% legend('Truth Path', 'Estimated Path', 'True Robot Heading', 'Estimated Robot Heading')

end

