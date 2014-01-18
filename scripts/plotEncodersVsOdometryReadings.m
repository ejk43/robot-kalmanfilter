
%% Set up the path
addpath('./../logs');
addpath('./..');

%% Get data
LogDirectory = './../logs';
LogName = 'Competition_Saturday_new';
data = readLogs(LogDirectory, LogName);
clear LogDirectory LogName

%% Use raw encoder data to determine velocities at the desired points
% At the odom sample times
% At the GPS sample times 
[~,enc_idx] = unique(data.enc(:,1));
enc_time = data.enc(enc_idx,1);
enc_data = data.enc(enc_idx,2:3);
enc_odom = [data.odom(:,1), interp1(enc_time,enc_data,data.odom(:,1))];
enc_gps  = [data.gps(:,1),  interp1(enc_time,enc_data,data.gps(:,1))];


%% Convert raw encoder measurements to velocity
[vel, omg] = convertEncodersToVelocity(enc_gps(:,1), enc_gps(:,2), enc_gps(:,3));


%% Plot Odometry
plotStart = 1; idx = 0;

figure(plotStart+idx); idx=idx+1;
px = [];
px(1) = subplot(3,1,1);
plot(data.enc(2:end,1), diff(data.enc(:,2:3))./repmat(diff(data.enc(:,1)),1,2)/1000,'.');
xlabel('Time (s)');
ylabel('Raw Encoder Velocity (kticks/s)');
title('Wheel Velocity sampled at new Raw Encoder Data');
px(2) = subplot(3,1,2);
plot(enc_odom(2:end,1), diff(enc_odom(:,2:3))./repmat(diff(enc_odom(:,1)),1,2)/1000,'.');
xlabel('Time (s)');
ylabel('Raw Encoder Difference (kticks/s)');
title('Wheel Velocity sampled at new Odometry Data');
px(3) = subplot(3,1,3);
plot(enc_gps(2:end,1), diff(enc_gps(:,2:3))./repmat(diff(enc_gps(:,1)),1,2)/1000,'.');
xlabel('Time (s)');
ylabel('Raw Encoder Difference (kticks/s)');
title('Wheel Velocity sampled at new GPS Data');
linkaxes(px,'x');

figure(plotStart+idx); idx=idx+1;
px = [];
px(1) = subplot(2,1,1);
plot(data.odom(:,1), data.odom(:,2), 'b-x', ...
     enc_gps(2:end,1), vel, 'r-x');
legend('ROS Vel','Processed Vel');
xlabel('Time (s)');
ylabel('Measured Velocity (m/s)');
title('Wheel Forward Velocity');
px(2) = subplot(2,1,2);
plot(data.odom(:,1), data.odom(:,3), 'b-x', ...
     enc_gps(2:end,1), omg, 'r-x');
legend('ROS Omega','Processed Omega');
xlabel('Time (s)');
ylabel('Measured Rotational Velocity (rad/s)');
title('Wheel Rotational Velocity');
linkaxes(px,'x');