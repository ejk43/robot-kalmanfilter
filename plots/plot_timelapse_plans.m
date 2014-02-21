function plot_timelapse_plans( hist, data, plotNum )
%PLOT_SIM_TIMELAPS_PLANS plots the robot timelapse for the PLANS 2014 document

downsample = 200;

radius = 0.5;

h1 = figure(100); clf; hold on;
% plot(state_true(:,1),state_true(:,2), '.', hist.x(:,1),hist.x(:,2), '.');
plot(hist.x(:,1),hist.x(:,2), '.');
plot(data.gps(:,2),data.gps(:,3), 'k.');
plot_robot(hist.x(50:end,:), downsample, h1, radius, 'r');
title('X,Y Location (Forward Pass)');
xlabel('X (m)'); ylabel('Y (m)');
axis square;
grid on;

legend('Estimated Path', 'GPS', 'Estimated Robot Heading')

end

