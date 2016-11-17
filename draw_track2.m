function draw_track2(x,y,handles)
axes(handles.axes1);
axis([-3000 3000 -2000 2000]);
plot(x,y,'or','LineWidth',1);
hold on;
handles.axes2.Color = [0.1 0.1 1];
set(gca,'XTick',-3000:1000:3000)  
set(gca,'XTickLabel',{'-30000','-20000','-10000','0','10000','20000','30000'})
set(gca,'YTick',-2000:1000:2000)  
set(gca,'YTickLabel',{'-20000','-10000','0','10000','20000'})