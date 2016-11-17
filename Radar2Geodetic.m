function [B,L] = Radar2Geodetic(ownB,ownL,distance,bearing)
mile=1852;

[x0,y0,z0]=TransformXYZ(ownB,ownL);
[x1,y1,z1]=TransformXYZ(ownB+1/3600,ownL);
[x2,y2,z2]=TransformXYZ(ownB,ownL+1/3600);

xi=[x1-x0, y1-y0, z1-z0];
xi=xi./((xi(1)^2+xi(2)^2+xi(3)^2)^0.5);
yi=[x2-x0, y2-y0, z2-z0];
yi=yi./((yi(1)^2+yi(2)^2+yi(3)^2)^0.5);

bearing=deg2rad(bearing);
distanceX=distance*mile*sin(bearing);
distanceY=distance*mile*cos(bearing);
ts=distanceX*xi+distanceY*yi;
[x,y,z]=TransformXYZ(ownB,ownL);
x=x+ts(1);
y=y+ts(2);
z=z+ts(3);
[B,L]=TransformBL(x,y,z);
end
