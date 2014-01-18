function [ data ] = load_data_ros( settings, data )
%LOAD_DATA reads data out of a ROS log

if isempty(data)
    data = readLogs('./../logs', settings.data.name);
else

end

