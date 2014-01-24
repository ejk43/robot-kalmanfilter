function [ vel, omg ] = convertEncodersToVelocity( time, encLeft, encRight,  settings)


% Todo: Replace with globals
if nargin < 4
    settings.tpm_right = 26500; % Ticks per meter
    settings.tpm_left= 27150; % Ticks per meter
	settings.track_m = 0.55; % Track Width
end

velRight = diff(encRight)/settings.tpm_right./diff(time);
velLeft = diff(encLeft)/settings.tpm_left./diff(time);

vel = (velRight+velLeft)/2;
omg = (velRight-velLeft)/settings.track_m;

end

