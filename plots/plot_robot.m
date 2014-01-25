function plot_robot(state, ndec, h)

figure(h);

for ii = ndec:ndec:size(state,1)
[x,y] = circle(state(ii,1),state(ii,2),state(ii,3));
plot(x,y,'r','Linewidth',3);
end

end