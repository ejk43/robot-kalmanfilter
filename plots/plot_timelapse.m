
downsample = 40;

h1 = figure(100); clf; hold on;
plot(hist.x(:,1),hist.x(:,2), '.');
plot(data.gps(:,2),data.gps(:,3), 'g.');
plot_robot(hist.x,downsample,h1);
title('X,Y Location (Forward Pass');
xlabel('X (m)'); ylabel('Y (m)');

h2 = figure(101); clf; hold on;
plot(hist.x_rts(:,1),hist.x_rts(:,2), '.');
plot(data.gps(:,2),data.gps(:,3), 'g.');
plot_robot(hist.x_rts,downsample,h2);
title('X,Y Location (Smoothed)');
xlabel('X (m)'); ylabel('Y (m)');