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
    traj_settings.std.ranger = 0.1;
    traj_settings.std.velocity = 0.005;
end

if ~isfield(traj_settings, 'dt')
    % Measurement Timestep: 
    % How often to make measurements (in seconds)
    traj_settings.dt.gps = 1/10;
    traj_settings.dt.imu = 1/25;
    traj_settings.dt.odom = 1/50;
    traj_settings.dt.ranger = 1/20;
    traj_settings.dt.velocity = 1/10;
end

if ~isfield(traj_settings, 'meas')
    % Measurement Settings: 
    % Instructions on how to generate measurements
    traj_settings.meas.imubias = 0.02;
    traj_settings.meas.useGPS = 1;
    traj_settings.meas.useIMU = 1;
    traj_settings.meas.useOdom = 1;
    traj_settings.meas.useRanger = 1;
    traj_settings.meas.useVelocity = 1;
    % rangerCoords is a p x 2 array. p = # of rangers. col = [x, y]
    traj_settings.meas.rangerCoords = [0, 0; 5, 5; 10, -5];
    
end

if ~isfield(traj_settings, 'fault')
    traj_settings.fault.useFault = 0;
    traj_settings.fault.useSystemParams = 0;
    
    traj_settings.fault.scaleL = 0.8;
    traj_settings.fault.scaleR = 1.2;
    traj_settings.fault.scaleB = 1.05;

    % faultTime is a m x 2 array. m = # of faults. col = [start, end]
    traj_settings.fault.faultTime = [20 30; 35 45];
    % faultMagn is a m x 2 array. m = # of faults. col = [left, right]
    traj_settings.fault.faultMagn = [0.5 0; 0 0.5]; 
end

end