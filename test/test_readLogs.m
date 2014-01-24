function tests = test_readLogs
% fcns = {@setupOnce; @teardownOnce; @testSimpleLog};
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
addpath('./../preprocessing');

logname = 'logtest';
mkdir(logname);

gpsdata = [0, 10, 10; 1, 20, 20];
csvwrite(fullfile(logname,'gps_file.txt'),gpsdata,1,0)

imudata = [0, 0.5; 1, 1];
csvwrite(fullfile(logname,'imu_file.txt'),imudata,1,0)

encdata = [0, 0, 0; 1, 1000, 2000];
csvwrite(fullfile(logname,'enc_file.txt'),encdata,1,0)

testCase.TestData.logname = logname;
testCase.TestData.gpsdata = gpsdata;
testCase.TestData.imudata = imudata;
testCase.TestData.encdata = encdata;
end

function teardownOnce(testCase)
delete(fullfile(testCase.TestData.logname,'gps_file.txt'));
delete(fullfile(testCase.TestData.logname,'imu_file.txt'));
delete(fullfile(testCase.TestData.logname,'enc_file.txt'));
rmdir(testCase.TestData.logname);
end

function testGPSData(testCase)
data = readLogs('.', testCase.TestData.logname);
verifyEqual(testCase, data.gps, testCase.TestData.gpsdata);
end

function testIMUData(testCase)
data = readLogs('.', testCase.TestData.logname);
verifyEqual(testCase, data.imu, testCase.TestData.imudata);
end

function testEncData(testCase)
data = readLogs('.', testCase.TestData.logname);
verifyEqual(testCase, data.enc, testCase.TestData.encdata);
end

