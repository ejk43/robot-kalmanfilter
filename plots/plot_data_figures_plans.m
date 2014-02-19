function plot_data_figures_plans( hist, plotNum )
%PLOT_DATA_FIGURES plots figures for the PLANS 2014 document


% state_true = hist.x_rts;

figure(plotNum); plotNum=plotNum+1; clf;
px = [];
px(1) = subplot(2,1,1); hold on;
ii =7;
plot(hist.t, hist.x(:,ii), 'b', hist.t, hist.x(:,ii)+3*sqrt(hist.P(:,ii,ii)), 'b:', hist.t, hist.x(:,ii)-3*sqrt(hist.P(:,ii,ii)), 'b:');
plot(hist.t, hist.x_rts(:,ii), 'r', hist.t, hist.x_rts(:,ii)+3*sqrt(hist.P_rts(:,ii,ii)), 'r:', hist.t, hist.x_rts(:,ii)-3*sqrt(hist.P_rts(:,ii,ii)), 'r:');
% plot(hist.t, state_true(:,ii), 'r');
title('Left Wheel Odometry Error');
xlabel('Time (s)'); ylabel('Velocity (m/s)');
grid on;
px(2) = subplot(2,1,2); hold on;
ii =8;
plot(hist.t, hist.x(:,ii), 'b', hist.t, hist.x(:,ii)+3*sqrt(hist.P(:,ii,ii)), 'b:', hist.t, hist.x(:,ii)-3*sqrt(hist.P(:,ii,ii)), 'b:');
plot(hist.t, hist.x_rts(:,ii), 'r', hist.t, hist.x_rts(:,ii)+3*sqrt(hist.P_rts(:,ii,ii)), 'r:', hist.t, hist.x_rts(:,ii)-3*sqrt(hist.P_rts(:,ii,ii)), 'r:');
% plot(hist.t, state_true(:,ii), 'r');
title('Right Wheel Odometry Error');
xlabel('Time (s)'); ylabel('Velocity (m/s)');
grid on;
linkaxes(px,'x');


figure(plotNum); plotNum=plotNum+1; clf;
px = [];
px(1) = subplot(3,1,1); hold on;
ii =9;
plot(hist.t, hist.x(:,ii), 'b', hist.t, hist.x(:,ii)+3*sqrt(hist.P(:,ii,ii)), 'b:', hist.t, hist.x(:,ii)-3*sqrt(hist.P(:,ii,ii)), 'b:');
plot(hist.t, hist.x_rts(:,ii), 'r', hist.t, hist.x_rts(:,ii)+3*sqrt(hist.P_rts(:,ii,ii)), 'r:', hist.t, hist.x_rts(:,ii)-3*sqrt(hist.P_rts(:,ii,ii)), 'r:');
% plot(hist.t, state_true(:,ii), 'r');
title('Odometry Left Wheel Ticks Per Meter Scaling');
xlabel('Time (s)'); ylabel('Velocity (m/s)');
% ylim([state_true(1,ii)-0.1, state_true(1,ii)+0.1]);
grid on;
px(2) = subplot(3,1,2); hold on;
ii =10;
plot(hist.t, hist.x(:,ii), 'b', hist.t, hist.x(:,ii)+3*sqrt(hist.P(:,ii,ii)), 'b:', hist.t, hist.x(:,ii)-3*sqrt(hist.P(:,ii,ii)), 'b:');
plot(hist.t, hist.x_rts(:,ii), 'r', hist.t, hist.x_rts(:,ii)+3*sqrt(hist.P_rts(:,ii,ii)), 'r:', hist.t, hist.x_rts(:,ii)-3*sqrt(hist.P_rts(:,ii,ii)), 'r:');
% plot(hist.t, state_true(:,ii), 'r');
title('Odometry Right Wheel Ticks Per Meter Scaling');
xlabel('Time (s)'); ylabel('Velocity (m/s)');
% ylim([state_true(1,ii)-0.1, state_true(1,ii)+0.1]);
grid on;
px(3) = subplot(3,1,3); hold on;
ii =11;
plot(hist.t, hist.x(:,ii), 'b', hist.t, hist.x(:,ii)+3*sqrt(hist.P(:,ii,ii)), 'b:', hist.t, hist.x(:,ii)-3*sqrt(hist.P(:,ii,ii)), 'b:');
plot(hist.t, hist.x_rts(:,ii), 'r', hist.t, hist.x_rts(:,ii)+3*sqrt(hist.P_rts(:,ii,ii)), 'r:', hist.t, hist.x_rts(:,ii)-3*sqrt(hist.P_rts(:,ii,ii)), 'r:');
% plot(hist.t, state_true(:,ii), 'r');
title('Odometry Track Width Scaling');
xlabel('Time (s)'); ylabel('Velocity (m/s)');
% ylim([state_true(1,ii)-0.1, state_true(1,ii)+0.1]);
grid on;
linkaxes(px,'x');

end

