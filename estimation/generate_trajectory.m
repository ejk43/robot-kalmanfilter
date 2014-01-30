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
traj.state = zeros(size(traj.t,1), 5);

% Integrate velocities
seg_idx = 1;
v = [0,0];
accel_limit = [settings.traj.vel_limit, settings.traj.omg_limit];
for ii = 2:size(traj.t,1)
    if traj.t(ii) > time(seg_idx, 1)
        seg_idx = seg_idx + 1;
    end
    [traj.state(ii,4:5), accel] = AccelLimit(segments(seg_idx-1,2:3), v, accel_limit, dt);
    traj.state(ii,1:3) = SimulateMotionPlain(traj.state(ii,4), traj.state(ii,5),...
        traj.state(ii-1,1:3)', dt);
end

% TODO: Add wheel velocity errors to simulated true state
% TODO: Add track width and encoder scaling states

end

