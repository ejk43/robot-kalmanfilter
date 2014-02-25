function [  ] = plot_montecarlo_state( all_hist, traj, state, fig )


time = all_hist(1).t;

nSamp = size(time, 1);
nSims = size(all_hist, 1);

state_data = zeros(nSamp, nSims);
for ii = 1:size(all_hist,1)
    state_data(:,ii) = all_hist(ii).x(:,state);
end

state_true = interp1(traj.t, traj.state(:,state), time);

% figure(fig);
plot(time, repmat(state_true, 1, nSims) - state_data, '.-');

end

