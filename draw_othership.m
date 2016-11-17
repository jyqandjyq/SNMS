function draw_othership(id,x,y,handles)
if abs(x)>3000 || abs(y)>2000
    return
end
ID = num2str(id);
Handles = handles;
axis([-3000 3000 -2000 2000]);
alpha=0:pi/20:2*pi;    %½Ç¶È[0,2*pi] 
R=30;                   %°ë¾¶ 
X=R*cos(alpha)+x; 
Y=R*sin(alpha)+y; 
plot(X,Y,'-') 
axis equal
fill(X,Y,'r');         %ÓÃºìÉ«Ìî³ä
text(x,y+65,ID,'Color','k','FontSize',5,'HorizontalAlignment','center');
axis([-3000 3000 -2000 2000]);
set(gca,'XTick',-3000:1000:3000)  
set(gca,'XTickLabel',{'-30000','-20000','-10000','0','10000','20000','30000'})
set(gca,'YTick',-2000:1000:2000)  
set(gca,'YTickLabel',{'-20000','-10000','0','10000','20000'})
hold on;