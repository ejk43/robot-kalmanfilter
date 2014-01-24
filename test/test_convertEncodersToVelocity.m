function tests = test_convertEncodersToVelocity
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
settings.tpm_right = 1000;
settings.tpm_left = 1000;
settings.track_m = 0.5;

testCase.TestData.settings = settings;
end

function testEncoderVelocity(testCase)
t = [0 1];
enc_right = [0 1000];
enc_left  = [0 1000];
[vel, ~] = convertEncodersToVelocity(t, enc_left, enc_right, testCase.TestData.settings);

verifyEqual(testCase, vel, 1);
end

function testEncoderOmega(testCase)
t = [0 1];
enc_left  = [0 0];
enc_right = [0 1000];
[~, omg] = convertEncodersToVelocity(t, enc_left, enc_right, testCase.TestData.settings);

verifyEqual(testCase, omg, 2);
end