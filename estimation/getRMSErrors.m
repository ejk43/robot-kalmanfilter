function [ rms ] = getRMSErrors( hist, traj)
%GETRMSERRORS finds the rms errors of the hist state compared to the true
%traj state

time = hist.t;
nStates = size(hist.x, 2);
nTime = size(time, 1);

state_true = interp1(traj.t, traj.state, time);

err = state_true - hist.x;
rms = sqrt(diag(err'*err)/nTime);

end

