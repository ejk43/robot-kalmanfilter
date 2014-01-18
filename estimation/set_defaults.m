function settings = set_defaults(settings)

if nargin < 1 
    settings = [];
end

if ~isfield(settings, 'data')
    settings.data.name = 'Competition_Saturday';
end

if ~isfield(settings, 'kf')
    
end

if ~isfield(settings, 'std')
    settings.std.gps = 0.02;
    settings.std.enc = 0.001;
    settings.std.imu = 0.02;
    settings.std.imubias = 0.0001;
end