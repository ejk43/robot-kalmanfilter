function [ traj ] = generate_trajectory(settings)
%GENERATE TRAJECTORY creates a robot path and returns the true state

%% Set up the file path
addpath('./../preprocessing');
addpath('./../kalmanfilter');
addpath('./../plots');
addpath('./../util');

%% Load Settings (if not supplied)
if nargin < 1
    settings = [];
end
settings = set_trajectory(settings);

%% Generate the track from the segments supplied
segments = settings.segments;
dt = settings.traj.dt;

time = [0; cumsum(segments(:,1))];

traj.t = (0:dt:time(end))';
traj.state = zeros(size(traj.t,1), 8);

% Integrate velocities
seg_idx = 1;
accel_limit = [settings.traj.vel_limit, settings.traj.omg_limit];
for ii = 2:size(traj.t,1)
    if traj.t(ii) > time(seg_idx, 1)
        seg_idx = seg_idx + 1;
    end
    [traj.state(ii,4:5), accel] = AccelLimit(segments(seg_idx-1,2:3), traj.state(ii-1,4:5), accel_limit, dt);
    traj.state(ii,1:3) = SimulateMotionPlain(traj.state(ii,4), traj.state(ii,5),...
        traj.state(ii-1,1:3)', dt);
end

% Add the IMU Bias state
traj.state(:,6) = settings.meas.imubias * ones(size(traj.t,1), 1);

% Add the wheel velocity error states
for fault = 1:size(settings.meas.faultTime,1)
    times = settings.meas.faultTime(fault,:);
    traj.state(times(1)<traj.t & traj.t<times(2), 7) = settings.meas.faultMagn(fault,1);
    traj.state(times(1)<traj.t & traj.t<times(2), 8) = settings.meas.faultMagn(fault,2);
end

% TODO: Add track width and encoder scaling states

end

