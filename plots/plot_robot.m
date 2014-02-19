function plot_robot(state, ndec, h, r, plotargs)


figure(h);

for ii = ndec:ndec:size(state,1)
    if nargin < 4
        [robot] = circle(state(ii,:));
    else
        [robot] = circle(state(ii,:), r);
    end
    if nargin < 5
        plot(robot(1,:), robot(2,:), 'r', 'Linewidth',3);
    else
        plot(robot(1,:), robot(2,:), plotargs, 'Linewidth',3);
    end
end

end
