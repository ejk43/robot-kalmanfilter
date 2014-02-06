function traj_settings = set_trajectory(traj_settings)
% SET_TRAJECTORY generates defaults for the true trajectory

if nargin < 1
    traj_settings = [];
end

% Log to use
if ~isfield(traj_settings, 'segments')
    % Each segment is in the form:
    %  [duration, forward velocity, angular velocity]
    traj_settings.segments = [10, 1, 0;
        2, 0, pi/4;
        10, 1, 0;
        2, 0, pi/4;
        10, 1, 0;
        2, 0, pi/4;
        8, 1, 0;
        10, 1, pi/8;
        10, 1, -pi/8 ];
end

if ~isfield(traj_settings, 'traj')
    % Trajectory settings
    traj_settings.traj.dt = 1/100;
    traj_settings.traj.vel_limit = 1;
    traj_settings.traj.omg_limit = 1;
end

if ~isfield(traj_settings, 'std')
    % Standard Deviations for Simulated Measurements
    traj_settings.std.gps = 0.025;
    traj_settings.std.imu = 0.002;
    traj_settings.std.odom = 0.001;
end

if ~isfield(traj_settings, 'dt')
    % Measurement Timestep: 
    % How often to make measurements (in seconds)
    traj_settings.dt.gps = 1/10;
    traj_settings.dt.imu = 1/25;
    traj_settings.dt.odom = 1/50;
end

if ~isfield(traj_settings, 'meas')
    % Measurement Settings: 
    % Instructions on how to generate measurements
    traj_settings.meas.imubias = 0.02;
    traj_settings.meas.useGPS = 1;
    traj_settings.meas.useIMU = 1;
    traj_settings.meas.useOdom = 1;
    
    traj_settings.meas.useFault = 0;
    traj_settings.meas.useSystemParams = 0;
    
    traj_settings.meas.scaleL = 0.8;
    traj_settings.meas.scaleR = 1.2;
    traj_settings.meas.scaleB = 1.05;

    % faultTime is a m x 2 array. m = # of faults. col = [start, end]
    traj_settings.meas.faultTime = [20 30; 35 45];
    % faultMagn is a m x 2 array. m = # of faults. col = [left, right]
    traj_settings.meas.faultMagn = [0.5 0; 0 0.5];
end

end