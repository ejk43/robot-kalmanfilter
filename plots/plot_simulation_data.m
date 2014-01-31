function [ ] = plot_simulation_data( data, traj, plotNum )
%Plots the simulation results

if nargin<3
    plotNum = 1;
end

%% GPS Data
figure(plotNum); plotNum = plotNum + 1;
plot(traj.state(:,1), traj.state(:,2), 'b.', traj.gps(:,1), traj.gps(:,2), 'r.', data.gps(:,2), data.gps(:,3), 'ko');
xlabel('X (m)'); ylabel('Y (m)');
title('Robot Track and Measurements');
legend('True', 'Perfect GPS', 'Downsampled Noisy GPS');
axis square;

%% IMU Data
figure(plotNum); plotNum = plotNum + 1;
plot(traj.t, traj.state(:,5), 'b.', traj.t, traj.imu, 'r.', data.imu(:,1), data.imu(:,2), 'ko');
xlabel('Time (s)'); ylabel('Angular Velocity (rad/s)');
title('Imu Truth and Measurements')
legend('True', 'Perfect IMU', 'Downsampled Noisy IMU');

%% Odometry Data
figure(plotNum); plotNum = plotNum + 1; px = [];
px(1) = subplot(2,1,1);
plot(traj.t, traj.odom(:,1), 'r.', data.odom(:,1), data.odom(:,2), 'ko');
xlabel('Time (s)'); ylabel('Forward Velocity (m/s)');
title('Left Wheel Odometry Measurements')
legend('Perfect Odom', 'Downsampled Noisy Odom');
px(2) = subplot(2,1,2);
plot(traj.t, traj.odom(:,2), 'r.', data.odom(:,1), data.odom(:,3), 'ko');
xlabel('Time (s)'); ylabel('Forward Velocity (m/s)');
title('Right Wheel Odometry Measurements')
legend('Perfect Odom', 'Downsampled Noisy Odom');


end

