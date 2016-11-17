
function R = GetXY_FromLonAndLat(Lon,Lat)
figure;
axesm  utm;

Z=utmzone(Lat,Lon);
setm(gca,'zone',Z);
h = getm(gca);
close figure 1;
[x,y]= mfwdtran(h,Lat,Lon);
R = [x,y];
end  