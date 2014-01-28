
%% Set up the path
addpath('./../logs');
addpath('./../preprocessing');

%% Get data
LogDirectory = './../logs';
LogName = 'Competition_Saturday';
data = readLogs(LogDirectory, LogName);
clear LogDirectory LogName

%% Plot GPS

plotStart = 10; idx = 0;

figure(plotStart+idx); idx=idx+1;
plot(data.gps(:,2),data.gps(:,3),'.');
xlabel('X (m)');
ylabel('Y (m)');
title('Raw Measured GPS')