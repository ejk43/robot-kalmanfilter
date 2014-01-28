%% Little Robot Movie

plotNum = 100;

% Decimate GPS by this number, decimate the state according to GPS timestamps
ndec = 10; 
pausetime = 0.1;
state = hist.x_rts;
time = data.gps(:,1);

idx_last = 1;
x_max = max(state(:,1))+2;
x_min = min(state(:,1))-2;
y_max = max(state(:,2))+2;
y_min = min(state(:,2))-2;
off = settings.robot.off_gps;
state_ds = interp1(hist.t, state, time);
for idx= ndec:ndec:size(state_ds,1)
    h = figure(plotNum); clf; hold on;
    [x,y] = circle(state_ds(idx,1),state_ds(idx,2),state_ds(idx,3), 0.3);
    gps_est = [state_ds(idx_last:idx,1) + off(1)*cos(state_ds(idx_last:idx,3)) - off(2)*sin(state_ds(idx_last:idx,3)),...
               state_ds(idx_last:idx,2) + off(1)*sin(state_ds(idx_last:idx,3)) + off(2)*cos(state_ds(idx_last:idx,3))];
    plot([state_ds(idx_last:idx,1) data.gps(idx_last:idx,2)],...
         [state_ds(idx_last:idx,2) data.gps(idx_last:idx,3)],'o',...
         gps_est(:,1),gps_est(:,2),'gx',...
         x,y,'r-','LineWidth',3);
    axis([x_min x_max y_min y_max])
    title(['Running: ' num2str(round(time(idx,1))) 's/' num2str(round(time(end,1))) 's'])
    idx_last = idx;
    pause(pausetime);
end
title(['DONE: ' num2str(round(hist.t(end,1))) 's/' num2str(round(hist.t(end,1))) 's'])