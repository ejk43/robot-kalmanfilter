function [meas] = h_ranger(x, loc)
%H_RANGER Creates the Ranger measurements given the ranger locations
% state = [x, y, theta, v, omega, imubias, ...
%          verrL, verrR, scaleTpmL, scaleTpmR, scaleB]'
% loc = p x 2 matrix, where p = number of rangers, col = [x, y]

meas = zeros(size(loc,1), size(x,2));
for ii = 1:size(loc,1)
    vec = x(1:2,:)-repmat(loc(ii,:)',1,size(x,2));
    meas(ii,:) = vnorm(vec,1);
end
% meas = [ ];