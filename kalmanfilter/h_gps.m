function [ meas ] = h_gps( x, off )
%H_GPS Creates the GPS measurements
%   x = state <- state is m by n, where m = number of states, n = number of
%   samples to calculate. States 1:3 must be: [x; y; theta]
%   off = [x_off; y_off] <- this is the lever arm offset

% % Find the expected measurement: h(state)
% gps_est = [x(1) + off(1)*cos(x(3)) - off(2)*sin(x(3));
%            x(2) + off(1)*sin(x(3)) + off(2)*cos(x(3))];

alloff = off;
if size(x,2)~= 1
    alloff = repmat(off, 1, size(x,2));
end

adjust = [off(1,:).*cos(x(3,:)) - off(2,:).*sin(x(3,:));
    off(1,:).*sin(x(3,:)) + off(2,:).*cos(x(3,:)) ];
meas = x(1:2,:) + adjust;

end

