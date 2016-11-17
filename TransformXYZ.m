function [X,Y,Z] = TransformXYZ(L,B)
a=6378137;
b=6356752;
e2=1-(b/a)^2;

B=deg2rad(B);
L=deg2rad(L);

N=a/((1-e2*sin(B).^2).^0.5);

X=N.*cos(B).*cos(L);
Y=N.*cos(B).*sin(L);
Z=N.*(1-e2).*sin(B);
end

