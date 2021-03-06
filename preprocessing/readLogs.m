function data = readLogs(directory, name)

logDir = getFullPath(directory, name);

name_imu = getFullPath(logDir, 'imu_file.txt');
name_odom = getFullPath(logDir, 'odom_file.txt');
name_gps = getFullPath(logDir, 'gps_file.txt');
name_state = getFullPath(logDir, 'state_file.txt');
name_cov = getFullPath(logDir, 'cov_file.txt');
name_enc = getFullPath(logDir, 'enc_file.txt');

if ~exist(logDir,'dir')
    error('Supplied directory is invalid');
end

if ~exist(name_enc, 'file') ||  ...
   ~exist(name_gps, 'file') || ...
   ~exist(name_imu, 'file')
    error(['Missing necessary file in directory ' logDir]);
end

% data.state = csvread(name_state,1,0);
% data.cov = csvread(name_cov,1,0);
% data.odom = csvread(name_odom,1,0);
data.imu = csvread(name_imu,1,0);
data.gps = csvread(name_gps,1,0);
data.enc = csvread(name_enc,1,0);

mintime = min([data.imu(:,1); data.gps(:,1); data.enc(:,1)]);
data.imu(:,1) = data.imu(:,1)-mintime;
data.gps(:,1) = data.gps(:,1)-mintime;
data.enc(:,1) = data.enc(:,1)-mintime;

end

function file = getFullPath(dir, filename)
file = filename;
if ~isempty(dir)
    file = ['./' dir '/' filename];
end
end