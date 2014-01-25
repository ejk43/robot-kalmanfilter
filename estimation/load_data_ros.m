function [ data ] = load_data_ros( settings, data )
%LOAD_DATA reads data out of a ROS log

if isempty(data)
    data = readLogs('./../logs', settings.data.name);
    if settings.data.Ts ~= -1 && settings.data.Te ~= -1
        data.gps = data.gps(settings.data.Ts < data.gps(:,1) & data.gps(:,1) < settings.data.Te, :);
        data.imu = data.imu(settings.data.Ts < data.imu(:,1) & data.imu(:,1) < settings.data.Te, :);
        data.enc = data.enc(settings.data.Ts < data.enc(:,1) & data.enc(:,1) < settings.data.Te, :);
    end
else

end

