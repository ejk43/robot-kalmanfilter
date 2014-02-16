function [x, P, Q, R] = initialize_kf(settings)

if nargin < 1
    settings = set_defaults();
end

%% Initialize Measurement Noise
R.gps = diag([settings.std.gps^2, settings.std.gps^2]);
R.imu = settings.std.imu^2;
R.range = diag(settings.std.ranger^2*ones(size(settings.env.rangerCoords,1),1));

R.force_velerr = settings.std.force_velerr;
R.force_syserr = settings.std.force_syserr;

%% Initial state, covariance, and system noise

% Base Model
% State: [x, y, tht, vel, omega, imubias]'
x = [settings.init.x;...
    settings.init.y;...
    settings.init.tht;...
    settings.init.vel;...
    settings.init.omg;...
    settings.init.imubias];
P_diag = [settings.cov.x;...
    settings.cov.y;...
    settings.cov.tht;...
    settings.cov.vel;...
    settings.cov.omg;...
    settings.cov.imubias];
Q_diag = [settings.sys.x^2;...
    settings.sys.y^2;...
    settings.sys.tht^2;...
    settings.sys.vel^2;...
    settings.sys.omg^2;...
    settings.sys.imubias^2];

% Add Wheel Error States
if settings.kf.useWheelError
    x = [x; ...
        settings.init.verr_l;...
        settings.init.verr_r];
    P_diag = [P_diag; ...
        settings.cov.verr_l;...
        settings.cov.verr_r];
    Q_diag = [Q_diag; ...
        settings.sys.verr_l;...
        settings.sys.verr_r];
end

% Add Systematic Odometry States
if settings.kf.useSystemParams
    x = [x; ...
        settings.init.scale_l;...
        settings.init.scale_r;...
        settings.init.scale_b];
    P_diag = [P_diag; ...
        settings.cov.scale_l;...
        settings.cov.scale_r;...
        settings.cov.scale_b];
    Q_diag = [Q_diag; ...
        settings.sys.scale_l;...
        settings.sys.scale_r;...
        settings.sys.scale_b];
end

P = diag(P_diag);
Q = diag(Q_diag);
