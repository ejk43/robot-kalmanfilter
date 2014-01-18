function [ vel, omg ] = convertEncodersToVelocity( time, encLeft, encRight )

% Todo: Replace with globals
TICKS_PER_M_RIGHT = 26500;
TICKS_PER_M_LEFT = 27150;
TRACK_WIDTH = 0.55;

velRight = diff(encRight)/TICKS_PER_M_RIGHT./diff(time);
velLeft = diff(encLeft)/TICKS_PER_M_LEFT./diff(time);

vel = (velRight+velLeft)/2;
omg = (velRight-velLeft)/TRACK_WIDTH;

end

