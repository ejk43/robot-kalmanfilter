
%% Set up the path
addpath('./../logs');
addpath('./..');

%% Get data
LogDirectory = './../logs';
LogName = 'Competition_Saturday';
data = readLogs(LogDirectory, LogName);
clear LogDirectory LogName

%% Use raw encoder data to determine velocities at the desired points

% 1. At the GPS sample times 
% 2. At uniform 50 Hz sample times
% 3. Downsampled by 2
% TODO: Shape the velocity response using a low pass on velocity (or
% something??) See fft of vel term

[~,enc_idx] = unique(data.enc(:,1));
enc_time = data.enc(enc_idx,1);
enc_data = data.enc(enc_idx,2:3);

enc_gps  = [data.gps(:,1),  interp1(enc_time,enc_data,data.gps(:,1))];

enc_dt_uniform = data.enc(1,1):1/50:(data.enc(1,1)+1/50*(size(data.enc,1)-1));
enc_uniform = [enc_dt_uniform', enc_data];

enc_downsamp = data.enc(1:2:end,:);


%% Convert raw encoder measurements to velocity
[vel, omg] = convertEncodersToVelocity(data.enc(:,1), data.enc(:,2), data.enc(:,3));
[vel_uniform, omg_uniform] = convertEncodersToVelocity(enc_uniform(:,1), enc_uniform(:,2), enc_uniform(:,3));
[vel_downsamp, omg_downsamp] = convertEncodersToVelocity(enc_downsamp(:,1), enc_downsamp(:,2), enc_downsamp(:,3));


%% Plot Odometry
plotStart = 1; idx = 0;

figure(plotStart+idx); idx=idx+1; clf; hold on;
subplot(2,1,1)
plot(diff(data.enc(:,1)),'.')
xlabel('Sample #');
ylabel('Timestep (s)');
title('Encoder data timesteps');
subplot(2,1,2)
enc_dt = diff(data.enc(:,1)); 
hist(enc_dt(abs(enc_dt-mean(enc_dt))<5*std(enc_dt)),100)
xlabel('Timestep Between Encoders (s)');
ylabel('Number of Occurences');
title('Encoder Timestep Histogram');

figure(plotStart+idx); idx=idx+1; clf; hold on;
subplot(2,1,1)
plot(diff(enc_downsamp(:,1)),'.')
xlabel('Sample #');
ylabel('Timestep (s)');
title('Downsampled Encoder data timesteps');
subplot(2,1,2)
enc_dt = diff(enc_downsamp(:,1)); 
hist(enc_dt(abs(enc_dt-mean(enc_dt))<5*std(enc_dt)),100)
xlabel('Timestep Between Encoders (s)');
ylabel('Number of Occurences');
title('Downsampled Encoder Timestep Histogram');

figure(plotStart+idx); idx=idx+1; clf; hold on;
px = [];
px(1) = subplot(3,1,1);
plot(data.enc(2:end,1), diff(data.enc(:,2:3))./repmat(diff(data.enc(:,1)),1,2)/1000,'.');
xlabel('Time (s)');
ylabel('Raw Encoder Velocity (kticks/s)');
title('Wheel Velocity sampled at new Raw Encoder Data');
px(2) = subplot(3,1,2);
plot(enc_uniform(2:end,1), diff(enc_uniform(:,2:3))./repmat(diff(enc_uniform(:,1)),1,2)/1000,'.');
xlabel('Time (s)');
ylabel('Raw Encoder Difference (kticks/s)');
title('Wheel Velocity at Uniform 50 Hz intervals');
px(3) = subplot(3,1,3);
plot(enc_gps(2:end,1), diff(enc_gps(:,2:3))./repmat(diff(enc_gps(:,1)),1,2)/1000,'.');
xlabel('Time (s)');
ylabel('Raw Encoder Difference (kticks/s)');
title('Wheel Velocity sampled at new GPS Data');
linkaxes(px,'x');

figure(plotStart+idx); idx=idx+1; clf; 
px = [];
px(1) = subplot(2,1,1); hold on;
plot(data.enc(2:end,1), vel, '-m');
plot(enc_uniform(2:end,1), vel_uniform, '-rx');
plot(enc_downsamp(2:end,1), vel_downsamp, '-bo');
xlabel('Time (s)');
ylabel('Measured Velocity (m/s)');
title('Wheel Forward Velocity');
legend('Raw Encoders','Uniform 50 Hz','Raw Encoders at 25 Hz')
px(2) = subplot(2,1,2); hold on;
plot(data.enc(2:end,1), omg, '-m');
plot(enc_uniform(2:end,1), omg_uniform, '-rx');
plot(enc_downsamp(2:end,1), omg_downsamp, '-bo');
xlabel('Time (s)');
ylabel('Measured Rotational Velocity (rad/s)');
title('Wheel Rotational Velocity');
legend('Raw Encoders','Uniform 50 Hz','Raw Encoders at 25 Hz')
linkaxes(px,'x');