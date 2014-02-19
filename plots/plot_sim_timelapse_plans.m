function plot_sim_timelapse_plans( hist, traj, data, plotNum )
%PLOT_SIM_TIMELAPS_PLANS plots the robot timelapse for the PLANS 2014 document

downsample = 150;

state_true = interp1(traj.t, traj.x, hist.t);
radius = 0.7;

h1 = figure(100); clf; hold on;
plot(state_true(:,1),state_true(:,2), '.', hist.x(:,1),hist.x(:,2), '.');
% plot(data.gps(:,2),data.gps(:,3), 'g.');
robot1 = circle(state_true(end,:), radius);
robot2 = circle(hist.x(end,:), radius);
        plot(robot1(1,:), robot1(2,:), 'm', 'Linewidth',3);
        plot(robot2(1,:), robot2(2,:), 'r', 'Linewidth',3);
plot_robot(state_true, downsample, h1, radius, 'm');
plot_robot(hist.x, downsample, h1, radius, 'r');
title('X,Y Location (Forward Pass)');
xlabel('X (m)'); ylabel('Y (m)');
axis square;
grid on;

legend('Truth Path', 'Estimated Path', 'True Robot Heading', 'Estimated Robot Heading')

end

