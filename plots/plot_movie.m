%% Little Robot Movie

plotNum = 100;

ndec = 5; % Decimate by 10 samples...
idx_last = 1;
x_max = max(hist.x(:,1))+2;
x_min = min(hist.x(:,1))-2;
y_max = max(hist.x(:,2))+2;
y_min = min(hist.x(:,2))-2;
off = settings.robot.off_gps;
state = hist.x_rts;
for idx= ndec:ndec:size(hist.t,1)
    h = figure(plotNum); clf; hold on;
    [x,y] = circle(state(idx,1),state(idx,2),state(idx,3), 0.3);
    gps_est = [state(idx_last:idx,1) + off(1)*cos(state(idx_last:idx,3)) - off(2)*sin(state(idx_last:idx,3)),...
               state(idx_last:idx,2) + off(1)*sin(state(idx_last:idx,3)) + off(2)*cos(state(idx_last:idx,3))];
    plot([state(idx_last:idx,1) data.gps(idx_last:idx,2)],...
         [state(idx_last:idx,2) data.gps(idx_last:idx,3)],'o',...
         gps_est(:,1),gps_est(:,2),'gx',...
         x,y,'r-','LineWidth',3);
    axis([x_min x_max y_min y_max])
    title(['Running: ' num2str(round(hist.t(idx,1))) 's/' num2str(round(hist.t(end,1))) 's'])
    idx_last = idx;
    pause(0.1);
end
title('DONE')