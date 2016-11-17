function [L,B] = TransformBL(X,Y,Z)
a=6378137;
b=6356752;
e2=1-(b/a)^2;

if X>0 && Y>0
    L=atan(Y./X);
elseif X<0 && Y>0
    L=pi+atan(Y./X);
elseif X<0 && Y<0
    L=-pi+atan(Y./X);
elseif X>0 && Y<0
    L=atan(Y./X);
elseif X==0 && Y>0
    L=pi/2;
elseif X==0 && Y<0
    L=-pi/2;
elseif X>0 && Y==0
    L=0;
elseif X<0 && Y==0
    L=pi;
end
B=atan((Z.*sin(L))./(Y.*(1-e2)));
L=rad2deg(L);
B=rad2deg(B);                                                                         
end

