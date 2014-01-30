function [ statenew ] = SimulateMotion( Vr, Vl, state, b, dt)
%SIMULATEMOTION simulates the motion of a differential drive robot
%   Given Vl, Vr, and the old state, this simulates the differential drive
%   mobile robot. 
%   Vr- Velocity of right wheel, m/s
%   Vl- Velocity of left wheel, m/s
%   state- (xold; yold; thtold) in (m, m, rad). Old state of robot
%   b- track width, m

xold = state(1,1);
yold = state(2,1);
thtold = state(3,1);

if abs(Vr-Vl) < 1e-6
    % Motion if w = 0
    xnew = xold + (Vr+Vl)/2*cos(thtold)*dt;
    ynew = yold + (Vr+Vl)/2*sin(thtold)*dt;
    thtnew = thtold;
else
    % Motion if w ~= 0
    xnew = xold + b*(Vr+Vl)/(2*(Vr-Vl))*(sin((Vr-Vl)*dt/b+thtold)-sin(thtold));
    ynew = yold - b*(Vr+Vl)/(2*(Vr-Vl))*(cos((Vr-Vl)*dt/b+thtold)-cos(thtold));
    thtnew = thtold + (Vr-Vl)/b*dt;
end

% % % % Wrap angles 0-2pi
% % % thtnew = mod(thtnew,2*pi);
% Wrap angles -pi to pi
thtnew = CoerceAngle(thtnew);

statenew = [xnew; ynew; thtnew];

end

