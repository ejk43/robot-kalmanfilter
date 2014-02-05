function [ state_pre, P_pre, Phi ] = ekf_sysm_update_basic(x, P, Qk, dt)
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'

% TODO: Clean up for different settings
nStates = size(x,1);

% Update State: x_pre = f(x,u), where x=state and u=0
state_pre = x;   % Next State = Current State
state_pre(1,1) = x(1) + x(4)*dt*cos(x(3)+x(5)*dt/2); % Equation for next x
state_pre(2,1) = x(2) + x(4)*dt*sin(x(3)+x(5)*dt/2); % Equation for next y
state_pre(3,1) = x(3) + x(5)*dt; % Equaltion for next heading)

             
% Calculate Phi (discrete transition matrix)
Phi = eye(nStates);

% Partial Derivatives of state_pre(1,1)
Phi(1,3) = -x(4)*dt*sin(x(3)+x(5)*dt/2);
Phi(1,4) = dt*cos(x(3)+x(5)*dt/2);
Phi(1,5) = -x(4)*dt*dt/2*sin(x(3)+x(5)*dt/2);

% Partial Derivatives of state_pre(2,1)
Phi(2,3) = x(4)*dt*cos(x(3)+x(5)*dt/2);
Phi(2,4) = dt*sin(x(3)+x(5)*dt/2);
Phi(2,5) = x(4)*dt*dt/2*cos(x(3)+x(5)*dt/2);

% Partial Derivatives of state_pre(3,1)
Phi(3,3) = 1;
Phi(3,4) = 0;
Phi(3,5) = dt;

% All other partial derivatives are equal to identity matrix


% Update Covariance: P_pre = F*P*F' + Qk
P_pre = Phi*P*Phi' + Qk;



end
