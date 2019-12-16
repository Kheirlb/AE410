h1=animatedline;
h2=animatedline;
axis([0,10,0,10]);
time=[0 1 2 3 4 5 6 7 8 9];
y1=[0 3 5 7 9 3 4 5 5 5];
y2=[0 1 3 4 5 1 3 4 4 4];
for k=1:length(time)
    addpoints(h1,time(k),y1(k));
    drawnow
    hold on
    addpoints(h2,time(k),y2(k));
    drawnow
    hold on
end