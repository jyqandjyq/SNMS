t=0:pi/10800:2*pi;
s=0:pi/10800:pi;
[T,S]=meshgrid(t,s);
clear t
clear s
a=6378137;
b=6356752;
x=a*sin(S).*cos(T);
save x x;
clear x;
y=a*sin(S).*sin(T);
save y y;
clear y;
z=b*cos(S);
clear S;
clear T;
load x;
load y;
save z z;

t=0:pi/10:2*pi;
s=0:pi/10:pi/2;
[T,S]=meshgrid(t,s);
a=5;
b=4;
x=a*sin(S).*cos(T);
y=a*sin(S).*sin(T);
z=b*cos(S);
surf(x,y,z);



