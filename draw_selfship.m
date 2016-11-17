function draw_selfship(theta,x,y,handles)
%theta是船头指向与正北方向夹角
%（x,y）是船的在平面坐标系中的坐标
if theta > 360
    theta = theta - 360;
end
axes(handles.axes1);
axis([-3000 3000 -2000 2000]);
handles.axes1.Color = [0.1 0.1 1];
x1 = -20+x:0.2:20+x;
y1 = -40*ones(1,201)+y;
x2 = -20*ones(1,401)+x;
y2 = -40+y:0.2:40+y;
x3 = 20*ones(1,401)+x;
y3 = -40+y:0.2:40+y;
x4 = -20+x:0.2:0+x;
y4 = (x4-x)*1.5+70+y;
x5 = 0+x:0.2:20+x;
y5 = (-x5+x)*1.5+70+y;

plot(x1,y1,'-r','LineWidth',1.5);
hold on;
plot(x2,y2,'-r','LineWidth',1.5);
plot(x3,y3,'-r','LineWidth',1.5);
plot(x4,y4,'-r','LineWidth',1.5);
plot(x5,y5,'-r','LineWidth',1.5);
h=allchild(gca);
rotate(h,[x,y,1],-theta,[x,y,0]);
axis([-3000 3000 -2000 2000]);
handles.axes1.Color = [0.1 0.1 1];
x6 = -3000 : 10 : 3000;
y6 = zeros(1,601);
plot(x6,y6,'--k');
x7 = zeros(1,401);
y7 = -2000 : 10 : 2000;
plot(x7,y7,'--k');
hold on;