%% Little Robot Movie

plotNum = 30;

ndec = 1; % Decimate by 10 samples...
idx_last = 1;
x_max = max(hist.x(:,1))+2;
x_min = min(hist.x(:,1))-2;
y_max = max(hist.x(:,2))+2;
y_min = min(hist.x(:,2))-2;
for idx= ndec:ndec:size(hist.t,1)
    h = figure(plotNum); clf; hold on;
    [x,y] = circle(hist.x(idx,1),hist.x(idx,2),hist.x(idx,3));
    plot([hist.x(idx_last:idx,1) data.gps(idx_last:idx,2)],...
         [hist.x(idx_last:idx,2) data.gps(idx_last:idx,3)],'.',...
         x,y,'r-','LineWidth',3);
    axis([x_min x_max y_min y_max])
    idx_last = idx;
    pause(0.1);
    
end