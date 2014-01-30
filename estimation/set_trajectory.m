function settings = set_trajectory(settings)
% SET_TRAJECTORY generates defaults for the true trajectory

if nargin < 1
    settings = [];
end

if ~isfield(settings, 'plot')
    % Trajectory settings
    settings.plot = 1;
end

% Log to use
if ~isfield(settings, 'segments')
    % Each segment is in the form:
    %  [duration, forward velocity, angular velocity]
    settings.segments = [10, 1, 0;
        2, 0, pi/4;
        10, 1, 0;
        2, 0, pi/4;
        10, 1, 0;
        2, 0, pi/4;
        8, 1, 0;
        10, 1, pi/8;
        10, 1, -pi/8 ];
end

if ~isfield(settings, 'traj')
    % Trajectory settings
    settings.traj.dt = 1/100;
    settings.traj.vel_limit = 100;
    settings.traj.omg_limit = 100;
end

if ~isfield(settings, 'std')
    % Standard Deviations for Simulated Measurements
    settings.std.gps = 0.05;
    settings.std.imu = 0.002;
    settings.std.odom = 0.001;
end

if ~isfield(settings, 'dt')
    % Measurement Timestep: 
    % How often to make measurements (in seconds)
    settings.dt.gps = 1/10;
    settings.dt.imu = 1/25;
    settings.dt.odom = 1/50;
end

if ~isfield(settings, 'meas')
    % Measurement Settings: 
    % Instructions on how to generate measurements
    settings.meas.imubias = 0.02;
    settings.meas.useGPS = 1;
    settings.meas.useIMU = 1;
    settings.meas.useOdom = 1;

    % faultTime is a m x 2 array. m = # of faults. col = [start, end]
    settings.meas.faultTime = [0 0];
    % faultMagn is a m x 2 array. m = # of faults. col = [left, right]
    settings.meas.faultMagn = [0 0];
end

end