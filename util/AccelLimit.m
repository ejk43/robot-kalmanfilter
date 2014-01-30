function [ v, accel ] = AccelLimit(vgoal, vlast, vdot, dt)
%ACCELLIMIT limits the velocities based on the previous velocities and the
%accelerations. All inputs must be scalars
% todo: generalize for matrix inputs
if any(any(size(vgoal)~=size(vlast)))
    error('Goal velocity must have same dimensions as last velocity')
end
if any(any(size(vgoal)~=size(vdot)))
    error('Goal velocity must have same dimensions as acceleration')
end
if length(dt)~=1
    error('dT Input must be a scalar')
end

inc = zeros(size(vgoal));
accel = zeros(size(vgoal));

% Accelerating up
up_idx = vgoal > vlast;
inc(up_idx) = vdot(up_idx)*dt;
accel(up_idx) = vdot(up_idx);

% Accelerating down
down_idx = vgoal < vlast;
inc(down_idx) = -vdot(down_idx)*dt;
accel(down_idx) = -vdot(down_idx);

% Change velocity
v = vlast + inc;

% Limit if we hit the goal
done_idx = (inc > 0 & v >= vgoal) | (inc < 0 & v <= vgoal);
v(done_idx) = vgoal(done_idx);

end

