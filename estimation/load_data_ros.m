function [ data ] = load_data_ros( settings, data )
%LOAD_DATA reads data out of a ROS log

if isempty(data)
    data = readLogs('./../logs', settings.data.name);
    if settings.data.Ts ~= -1 && settings.data.Te ~= -1
        data.gps = data.gps(settings.data.Ts < data.gps(:,1) & data.gps(:,1) < settings.data.Te, :);
        data.imu = data.imu(settings.data.Ts < data.imu(:,1) & data.imu(:,1) < settings.data.Te, :);
        data.enc = data.enc(settings.data.Ts < data.enc(:,1) & data.enc(:,1) < settings.data.Te, :);
    end
    [vel_lft, vel_rgt] = convertEncodersToWheelVelocity(data.enc(:,1), data.enc(:,2), data.enc(:,3), settings.robot);
    data.odom = [ data.enc(1:end,1), [0;vel_lft], [0;vel_rgt]];
else
    if ~isfield(data, 'gps') && settings.kf.useGPS
        error('Missing GPS field in supplied data structure. Add gps data or turn off "settings.kf.useGPS"');
    end
    if ~isfield(data, 'imu') && settings.kf.useIMU
        error('Missing IMU field in supplied data structure. Add imu data or turn off "settings.kf.useIMU"');
    end
    if ~isfield(data, 'odom') && settings.kf.useGPS
        error('Missing Odom field in supplied data structure. Add odom data or turn off "settings.kf.useOdom"');
    end
end

