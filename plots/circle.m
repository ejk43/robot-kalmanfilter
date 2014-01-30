function [robot, leftarrow, rightarrow] = circle(state, r)

x = state(1);
y = state(2);
tht = state(3);
verr_r = 1;
verr_l = 1;
if size(state,2) > 6
    verr_r = state(7);
    verr_l = state(8);
end

if nargin < 2
    r = 0.15;
end


th = 0:pi/50:2*pi;
xunit = r * cos(th);
yunit = r * sin(th);
xunit = [0,xunit];
yunit = [0,yunit];

R = [cos(tht) -sin(tht); sin(tht) cos(tht)];
robot = R*[xunit;yunit] + repmat(state(1:2)', 1, size(xunit,2));
% xrobot = pts(1,:)+x;
% yrobot = pts(2,:)+y;
% robot = [pts(1,:)+x; pts(2,:)+y];

% leftarrow = R*[0;r] + [x;y];
% if verr_l > 0.1
    s = 2*r;
    xleft = [0 s*verr_l s*verr_l-s*verr_l*0.25 s*verr_l s*verr_l-s*verr_l*0.25];
    yleft = [r r r+0.25*r r r-0.25*r];
    leftarrow = R*[xleft;yleft] + repmat(state(1:2)', 1, size(xleft,2));
% end

% rightarrow = R*[0;r] + [x;y];
% if verr_r > 0.1
    s = 2*r;
    xright = [0 s*verr_r s*verr_r-s*verr_r*0.25 s*verr_r s*verr_r-s*verr_r*0.25];
    yright = [-r -r -r+0.25*r -r -r-0.25*r];
    rightarrow = R*[xright;yright] + repmat(state(1:2)', 1, size(xright,2));
% end

% xout = [xrobot; xleft; xright];
% yout = [yrobot; yleft; yright];