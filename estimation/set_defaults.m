function settings = set_defaults(settings)
%SET_DEFAULTS generates default settings for the KF

if nargin < 1
    settings = [];
end

% Log to use
if ~isfield(settings, 'data')
    %     settings.data.name = 'Competition_Saturday';
    settings.data.name = 'Competition_Sunday_Run1';
    %     settings.data.name = 'Competition_Sunday_Run2';
    %     settings.data.name = 'LaserTest_Drive';
    settings.data.Ts = 0; % Start Time
    settings.data.Te = 150; % End Time
end

if ~isfield(settings, 'plot');
    settings.plot = 0;
end

% EKF Settings
if ~isfield(settings, 'kf')
    settings.kf.useGPS = 1;
    settings.kf.useIMU = 1;
    settings.kf.useOdom = 1;
    settings.kf.useWheelError = 1;
    settings.kf.useSystemParams = 1;
    
    settings.kf.smooth = 1;
end

if ~isfield(settings, 'fault')
    % faultTime is a m x 2 array. m = # of faults. col = [start, end]
    settings.fault.scaleTime = [0 0];
    % faultMagn is a m x 3 array. m = # of faults. col = [scaleL, scaleR, scaleB]
    settings.fault.scaleVal = [1 1 1];
    
    % faultTime is a m x 2 array. m = # of faults. col = [start, end]
    settings.fault.slipTime = [0 0];
    % faultMagn is a m x 2 array. m = # of faults. col = [left, right]
    settings.fault.slipMagn = [0 0];
end

% EKF System Tuning (Standard Deviation)
if ~isfield(settings, 'sys')
    settings.sys.x = 0.01;
    settings.sys.y = 0.01;
    settings.sys.tht = 0.01;
    settings.sys.vel = 0.1;
    settings.sys.omg = 0.01;
    settings.sys.verr_r = 0.01;
    settings.sys.verr_l = 0.01;
    settings.sys.imubias = 0.00005;
    settings.sys.scale_l = 0.00001;
    settings.sys.scale_r = 0.00001;
    settings.sys.scale_b = 0.00001;
end

% EKF Measurement Tuning (Standard Deviation)
if ~isfield(settings, 'std')
    settings.std.gps = 0.05;
    settings.std.imu = 0.01;
    settings.std.enc_eps = 0.005;
    settings.std.enc_alp = 0.003;
end

% Initial Covariance
if ~isfield(settings, 'cov')
    settings.cov.x = 100;
    settings.cov.y = 100;
    settings.cov.tht = pi;
    settings.cov.vel = 1;
    settings.cov.omg = 1;
    settings.cov.imubias = 0.1;
    settings.cov.verr_r = 0.01;
    settings.cov.verr_l = 0.01;
    settings.cov.scale_l = 0.001;
    settings.cov.scale_r = 0.001;
    settings.cov.scale_b = 0.001;
end

% Initial Covariance
if ~isfield(settings, 'init')
    settings.init.x = 0;
    settings.init.y = 0;
    settings.init.tht = 0;
    settings.init.vel = 0;
    settings.init.omg = 0;
    settings.init.imubias = 0;
    settings.init.verr_r = 0;
    settings.init.verr_l = 0;
    settings.init.scale_l = 1;
    settings.init.scale_r = 1;
    settings.init.scale_b = 1;
end


% Robot constants
if ~isfield(settings, 'robot')
    settings.robot.tpm_right = 26500; % Ticks per meter, Right Wheel
    settings.robot.tpm_left= 27150; % Ticks per meter, Left Wheel
    settings.robot.track_m = 0.55; % Track Width
%     settings.robot.off_gps = [0; 0]; % GPS offset in body frame
        settings.robot.off_gps = [-0.45; 0]; % GPS offset in body frame
end

end