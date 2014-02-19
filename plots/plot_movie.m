%% Little Robot Movie

plotNum = 100;

% Decimate GPS by this number, decimate the state according to GPS timestamps
ndec = 2;
pausetime = 0.1;
state_data = hist.x;
% state_data = hist.x_rts;
time = data.gps(:,1);

state = zeros(size(state_data,1),11);
state(:,1:6) = state_data(:,1:6);
if settings.kf.useWheelError
    state(:,7:8) = state_data(:,7:8);
end

% vidObj = VideoWriter('robot2.avi');
% open(vidObj);

idx_last = 1;
x_max = max(state(10:end,1))+2;
x_min = min(state(10:end,1))-2;
y_max = max(state(10:end,2))+2;
y_min = min(state(10:end,2))-2;
off = settings.robot.off_gps;
state_ds = interp1(hist.t, state, time);
for idx= ndec:ndec:size(state_ds,1)
    h = figure(plotNum); clf; hold on;
    [robot, leftarrow, rightarrow] = circle(state_ds(idx,:), 0.3);
    gps_est = [state_ds(idx_last:idx,1) + off(1)*cos(state_ds(idx_last:idx,3)) - off(2)*sin(state_ds(idx_last:idx,3)),...
        state_ds(idx_last:idx,2) + off(1)*sin(state_ds(idx_last:idx,3)) + off(2)*cos(state_ds(idx_last:idx,3))];
    plot([state_ds(idx_last:idx,1) data.gps(idx_last:idx,2)],...
        [state_ds(idx_last:idx,2) data.gps(idx_last:idx,3)],'o',...
        gps_est(:,1),gps_est(:,2),'gx',...
        robot(1,:),robot(2,:),'r-',...
        leftarrow(1,:),leftarrow(2,:),'b-',...
        rightarrow(1,:),rightarrow(2,:),'b-','LineWidth',3);
    axis([x_min x_max y_min y_max])
    title(['Running: ' num2str(round(time(idx,1))) 's/' num2str(round(time(end,1))) 's'])
    idx_last = idx;
%     axis square
%     currFrame = getframe;
%     writeVideo(vidObj,currFrame);
    pause(pausetime);
end
title(['DONE: ' num2str(round(hist.t(end,1))) 's/' num2str(round(hist.t(end,1))) 's'])

% currFrame = getframe;
% writeVideo(vidObj,currFrame);
% close(vidObj);