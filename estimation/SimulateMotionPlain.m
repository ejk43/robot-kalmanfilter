function [ statenew ] = SimulateMotionPlain( vel, omg, state, dt)
%SIMULATEMOTIONPLAIN simulates the motion of a differential drive robot
%   Given Vel, Omg, and the old state, this simulates the differential drive
%   mobile robot. 
%   Vel- Forward Velocity, m/s
%   Omg- Angular Velocity, rad/s
%   state- (xold; yold; thtold) in (m, m, rad). Old state of robot

xold = state(1,1);
yold = state(2,1);
thtold = state(3,1);

if abs(omg) < 1e-6
    % Motion if w = 0
    xnew = xold + vel*cos(thtold)*dt;
    ynew = yold + vel*sin(thtold)*dt;
    thtnew = thtold;
else
    % Motion if w ~= 0
    xnew = xold + vel/omg*(sin(omg*dt+thtold)-sin(thtold));
    ynew = yold - vel/omg*(cos(omg*dt+thtold)-cos(thtold));
    thtnew = thtold + omg*dt;
end

% % Wrap angles -pi to pi
% thtnew = wrap(thtnew, 2*pi);

statenew = [xnew; ynew; thtnew];

end

