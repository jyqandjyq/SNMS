% clc;
% clear all;
% 
% load aisData;
index=find([aisData.UserID]==aisData(1).UserID);
Longitude=[aisData(index).Longitude];
Latitude=[aisData(index).Latitude];
figure(1)
plot(Longitude,Latitude);
hold on
figure(2)
scatter(Longitude,Latitude);
hold on