function [x_rts_all, P_rts_all] = SmoothRTS(Phi, x_est, x_pre, P_est, P_pre)
% SMOOTHRTS- RTS post postprocesser. Smoothes the data output from a Filter
%  
%   inputs:
%     - Phi: Can be a constant or a (T x N x N) matrix 
%     - x_est: State estimates after measurement update: (T x N) matrix
%     - x_pre: State estimates before meas. update: (T x N) matrix
%     - P_est: Cov estimate after measurement update: (T x N x N) matrix
%     - P_cov: Cov estimate before meas. update: (T x N x N) matrix
%   T = number of timesteps
%   N = number of states
%
%  outputs:
%     - x_rts_all: State estimate after RTS smoothing: (T x N) matrix
%     - P_rts_all: Cov estimate after RTS smoothing: (T x N x N) matrix

nSteps  = size(x_est,1);
nStates = size(x_est,2);

const_phi = 1;
if ndims(Phi) == 2
    Phi_now = Phi;
    if all(size(Phi) ~= [nStates, nStates])
        error('Phi input does not have correct number of states');
    end
elseif ndims(Phi) == 3
    const_phi = 0;
    if size(Phi,1) ~= nSteps
        error('Variable Phi input must have same number of timesteps as x_est input');
    end
else
    error('Incorrect dimensions for Phi input');
end

% Initialize RTS smoother states
x_rts = x_est(end,:)';
P_rts = squeeze(P_est(end,:,:));

% Initialize history
x_rts_all  = zeros(nSteps,size(x_rts,1));
P_rts_all  = zeros(nSteps,size(P_rts,1),size(P_rts,2));

x_rts_all(nSteps,:) = x_rts';
P_rts_all(nSteps,:,:) = P_rts;

% Run the RTS Smoother
for jj = (nSteps-1):-1:1
    
    % Get data
    x_est_now = x_est(jj,:)';
    x_pre_nxt = x_pre(jj+1,:)';
    P_est_now = squeeze(P_est(jj,:,:));
    P_pre_nxt = squeeze(P_pre(jj+1,:,:));
    
    if const_phi == 0
        Phi_now = squeeze(Phi(jj,:,:));
    end
    
    % RTS Smoother
    K = P_est_now*Phi_now'*inv(P_pre_nxt);
    P_rts_new = P_est_now + K*(P_rts - P_pre_nxt)*K';
    x_rts_new = x_est_now + K*(x_rts - x_pre_nxt);
    
    P_rts = P_rts_new;
    x_rts = x_rts_new;
    
    % Save RTS data
    x_rts_all(jj,:) = x_rts';
    P_rts_all(jj,:,:) = P_rts;
end


end