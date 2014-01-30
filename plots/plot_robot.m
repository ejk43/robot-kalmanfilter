function plot_robot(state, ndec, h)

figure(h);

for ii = ndec:ndec:size(state,1)
[robot] = circle(state(ii,:));
plot(robot(1,:), robot(2,:), 'r', 'Linewidth',3);
end

end