function [ ] = plot_simulation_data( data, traj, plotNum )
%Plots the simulation results

if nargin<3
    plotNum = 1;
end

%% GPS Data
figure(plotNum); plotNum = plotNum + 1;
plot(data.gps(:,2), data.gps(:,3), 'ko', traj.state(:,1), traj.state(:,2), 'b.', traj.gps(:,1), traj.gps(:,2), 'r.');
xlabel('X (m)'); ylabel('Y (m)');
title('Robot Track and Measurements');
legend('Downsampled Noisy GPS', 'True Robot Origin', 'Perfect GPS');
axis square;

%% IMU Data
figure(plotNum); plotNum = plotNum + 1;
plot(data.imu(:,1), data.imu(:,2), 'ko', traj.t, traj.state(:,5), 'b.', traj.t, traj.imu, 'r.');
xlabel('Time (s)'); ylabel('Angular Velocity (rad/s)');
title('Imu Truth and Measurements')
legend( 'Downsampled Noisy IMU', 'True', 'Perfect IMU');

%% Odometry Data
figure(plotNum); plotNum = plotNum + 1; px = [];
px(1) = subplot(2,1,1);
plot(data.odom(:,1), data.odom(:,2), 'ko', traj.t, traj.odom(:,1), 'r.');
xlabel('Time (s)'); ylabel('Forward Velocity (m/s)');
title('Left Wheel Odometry Measurements')
legend('Downsampled Noisy Odom', 'Perfect Odom');
px(2) = subplot(2,1,2);
plot(data.odom(:,1), data.odom(:,3), 'ko', traj.t, traj.odom(:,2), 'r.');
xlabel('Time (s)'); ylabel('Forward Velocity (m/s)');
title('Right Wheel Odometry Measurements')
legend('Downsampled Noisy Odom', 'Perfect Odom');
linkaxes(px,'x');

%% Ranger Data
figure(plotNum); plotNum = plotNum + 1; px = [];
nRanger = size(traj.range, 2); hold on;
plot(traj.t, traj.range, '.')
plot(data.range(:,1), data.range(:,2:end), 'ko', traj.t, traj.range, '.')
xlabel('Time (s)'); ylabel('Distance (m)');
names = cell(nRanger, 1);
for ii = 1:nRanger
    names(ii) = {['Ranger ' num2str(ii)]};
end
legend(names)
title('Ranger Measurements')

%% Visual Odometry Data
figure(plotNum); plotNum = plotNum + 1; px = [];
px(1) = subplot(2,1,1);
plot(data.velocity(:,1), data.velocity(:,2), 'ko', traj.t, traj.velocity(:,1), 'r.');
xlabel('Time (s)'); ylabel('Forward Velocity (m/s)');
title('Forward Velocity Measurements')
legend('Downsampled Noisy Velocity', 'Perfect Velocity');
px(2) = subplot(2,1,2);
plot(data.velocity(:,1), data.velocity(:,3), 'ko', traj.t, traj.velocity(:,2), 'r.');
xlabel('Time (s)'); ylabel('Angular Velocity (rad/s)');
title('Angular Velocity Measurements')
legend('Downsampled Noisy Velocity', 'Perfect Velocity');
linkaxes(px,'x');

end

