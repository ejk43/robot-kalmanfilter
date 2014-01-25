function [xout,yout] = circle(x,y,tht)

th = 0:pi/50:2*pi;
r = 0.15; %radius
xunit = r * cos(th);
yunit = r * sin(th);
xunit = [0,xunit];
yunit = [0,yunit];

R = [cos(tht) -sin(tht); sin(tht) cos(tht)];
pts = R*[xunit;yunit];
xout = pts(1,:)+x;
yout = pts(2,:)+y;