function [ hist, data ] = process_robot_data(settings, data)
%PROCESS_ROBOT_DATA 

%% Set up the path
addpath('./../preprocessing');
addpath('./../kalmanfilter');

%% Load Settings (if not supplied)
if nargin < 1
    settings = [];
end
settings = set_defaults(settings);

%% Load Data (if not supplied)
if nargin < 2
    data = [];
end
data = load_data_ros(settings,data);

%% Preprocess as necessary

%% Main Filtering Loop

%% Smoothing?


end

