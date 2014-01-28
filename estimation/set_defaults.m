function settings = set_defaults(settings)

if nargin < 1 
    settings = [];
end

% Log to use
if ~isfield(settings, 'data')
    settings.data.name = 'Competition_Saturday';
%     settings.data.name = 'LaserTest_Drive';
    settings.data.Ts = -1; % Start Time
    settings.data.Te = -1; % End Time
end

if ~isfield(settings, 'plot');
    settings.plot = 0;
end

% EKF Settings
if ~isfield(settings, 'kf')
    settings.kf.useGPS = 1;
    settings.kf.useIMU = 1;
    settings.kf.useOdom = 1;
    settings.kf.useWheelError = 0;
    
    settings.kf.smooth = 1;
    
%     settings.kf.nStates = 6;
%     settings.kf.state = zeros(settings.kf.nStates, 1);
end

% EKF Measurement Tuning (Standard Deviation)
if ~isfield(settings, 'std') 
    settings.std.gps = 0.05;
    settings.std.imu = 0.01;
    settings.std.enc_eps = 0.005;
    settings.std.enc_alp = 0.003;
end

% EKF System Tuning (Standard Deviation)
if ~isfield(settings, 'sys') 
    settings.sys.x = 0.01;
    settings.sys.y = 0.01;
    settings.sys.tht = 0.01;
    settings.sys.vel = 0.05;
    settings.sys.omg = 0.05;
    settings.sys.verr_r = 0.01;
    settings.sys.verr_l = 0.01;
    settings.sys.imubias = 0.00005;
end

% Initial Covariance
if ~isfield(settings, 'cov')
    settings.cov.x = 100;
    settings.cov.y = 100;
    settings.cov.tht = pi;
    settings.cov.vel = 1;
    settings.cov.omg = 1;
    settings.cov.imubias = 0.1;
    settings.cov.verr_r = 0.1;
    settings.cov.verr_l = 0.1; 
end
    
% Robot constants
if ~isfield(settings, 'robot')
    settings.robot.tpm_right = 26500; % Ticks per meter, Right Wheel
    settings.robot.tpm_left= 27150; % Ticks per meter, Left Wheel
	settings.robot.track_m = 0.55; % Track Width
    settings.robot.off_gps = [0 0]; % GPS offset in body frame
end

end