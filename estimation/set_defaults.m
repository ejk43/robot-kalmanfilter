function settings = set_defaults(settings)

if nargin < 1 
    settings = [];
end

% Log to use
if ~isfield(settings, 'data')
    settings.data.name = 'Competition_Saturday';
end

if ~isfield(settings, 'plot');
    settings.plot = 1;
end

% EKF Settings
if ~isfield(settings, 'kf')
    settings.kf.type = 'Vel';
    settings.kf.nStates = 5;
    settings.kf.state = zeros(settings.kf.nStates, 1);
%     settings.kf.cov = [100, 100, pi, 1, 1, 0.1, 0.1];
    settings.kf.cov = [100, 100, pi, 1, 1];
    settings.kf.smooth = 1;
end

% EKF Measurement Tuning (Standard Deviation)
if ~isfield(settings, 'std') 
    settings.std.gps = 0.05;
    settings.std.enc = 0.001;
    settings.std.imu = 0.02;
    settings.std.imubias = 0.0001;
end

% EKF System Tuning (Standard Deviation)
if ~isfield(settings, 'sys') 
    settings.sys.x = 0.01;
    settings.sys.y = 0.01;
    settings.sys.tht = 0.001;
    settings.sys.vel = 0.01;
    settings.sys.omg = 0.01;
    settings.sys.verr_r = 0.1;
    settings.sys.verr_l = 0.1;
end
    
% Robot constants
if ~isfield(settings, 'robot')
    settings.robot.tpm_right = 26500; % Ticks per meter, Right Wheel
    settings.robot.tpm_left= 27150; % Ticks per meter, Left Wheel
	settings.robot.track_m = 0.55; % Track Width
    settings.robot.off_gps = [0 0]; % GPS offset in body frame
end

end