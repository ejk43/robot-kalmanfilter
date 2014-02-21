function plot_data_odomerrs_plans( hist, plotNum )
%plot_data_odomerrs_plans plots figures for the PLANS 2014 document
% Includes true states for scaling parameters

% state_true = hist.x_rts

ts = 0;
te = 1000;

scale1 = 1/0.9;
scale2 = 1/1.2;
scale3 = 1/1.1;

figure(plotNum); plotNum=plotNum+1; clf;
px = [];
px(1) = subplot(3,1,1); hold on;
ii =9;
plot(hist.t, hist.x(:,ii), 'b', hist.t, hist.x(:,ii)+3*sqrt(hist.P(:,ii,ii)), 'b:', hist.t, hist.x(:,ii)-3*sqrt(hist.P(:,ii,ii)), 'b:');
% plot(hist.t, state_true(:,ii), 'r');
plot([hist.t(1) hist.t(end)], [scale1 scale1], 'r');
title('Odometry Left Wheel Ticks Per Meter Scaling');
xlabel('Time (s)'); ylabel('Velocity (m/s)');
% ylim([state_true(1,ii)-0.1, state_true(1,ii)+0.1]);
grid on;
px(2) = subplot(3,1,2); hold on;
ii =10;
plot(hist.t, hist.x(:,ii), 'b', hist.t, hist.x(:,ii)+3*sqrt(hist.P(:,ii,ii)), 'b:', hist.t, hist.x(:,ii)-3*sqrt(hist.P(:,ii,ii)), 'b:');
% plot(hist.t, state_true(:,ii), 'r');
plot([hist.t(1) hist.t(end)], [scale2 scale2], 'r');
title('Odometry Right Wheel Ticks Per Meter Scaling');
xlabel('Time (s)'); ylabel('Velocity (m/s)');
% ylim([state_true(1,ii)-0.1, state_true(1,ii)+0.1]);
grid on;
px(3) = subplot(3,1,3); hold on;
ii =11;
plot(hist.t, hist.x(:,ii), 'b', hist.t, hist.x(:,ii)+3*sqrt(hist.P(:,ii,ii)), 'b:', hist.t, hist.x(:,ii)-3*sqrt(hist.P(:,ii,ii)), 'b:');
% plot(hist.t, state_true(:,ii), 'r');
plot([hist.t(1) hist.t(end)], [scale3 scale3], 'r');
title('Odometry Track Width Scaling');
xlabel('Time (s)'); ylabel('Velocity (m/s)');
% ylim([state_true(1,ii)-0.1, state_true(1,ii)+0.1]);
grid on;
linkaxes(px,'x');

end

