function draw_selfship(theta,x,y,handles)
%theta是船头指向与正北方向夹角
%（x,y）是船的在平面坐标系中的坐标
if theta > 360
    theta = theta - 360;
end
axes(handles.axes1);
axis([-1500 1500 -1000 1000]);
handles.axes1.Color = [0.1 0.1 1];
x1 = -1500 : 10 : 1500;
y1 = zeros(1,301);
plot(x1,y1,'--k');
hold on;
x1 = -10+x:0.2:10+x;
y1 = -20*ones(1,101)+y;
x2 = -10*ones(1,201)+x;
y2 = -20+y:0.2:20+y;
x3 = 10*ones(1,201)+x;
y3 = -20+y:0.2:20+y;
x4 = -10+x:0.2:0+x;
y4 = (x4-x)*1.5+35+y;
x5 = 0+x:0.2:10+x;
y5 = (-x5+x)*1.5+35+y;
axes(handles.axes1);
axis([-1500 1500 -1000 1000]);
plot(x1,y1,'-r','LineWidth',1.5);
hold on;
plot(x2,y2,'-r','LineWidth',1.5);
plot(x3,y3,'-r','LineWidth',1.5);
plot(x4,y4,'-r','LineWidth',1.5);
plot(x5,y5,'-r','LineWidth',1.5);
h=allchild(gca);
rotate(h,[x,y,1],-theta,[x,y,0]);
axis([-1500 1500 -1000 1000]);
handles.axes1.Color = [0.1 0.1 1];