function Initialize()
global aisQueue;
global arpaQueue;
global selfAis;
global arpaData;
global aisData;
global P;

aisQueue=[];
arpaQueue=[];
selfAis=[];
arpaData=nan*zeros(100,5);
aisData=zeros(0,5);
P=zeros(0,2);

global Time;
global selfB;
global selfL;
global target;
global arpaTargetNo;
global aisTargetId;
global targetNum;

targetNum=10;                 %target number
selfB=-180+rand*360;     %self Longitude
selfL=-90+rand*180;       %self Latitude

target=zeros(targetNum,5);   %[Longitude,Latitude,speed,heading,distance,bearing,turning rate]
for i=1:targetNum
    target(i,4)=rand*360;
    target(i,5)=5+5*rand;
    target(i,6)=rand*360;
    [target(i,1),target(i,2)]=Radar2Geodetic(selfB,selfL,target(i,5),target(i,6));
    target(i,3)=50+rand*50;
    target(i,7)=0.99+rand*0.02;
end

arpaTargetNo=nan*zeros(1,100);
aisTargetId=zeros(1,targetNum);
Time=1468042607;

idPool=[874802897,972586686,136351055,980729857,678990570,104733212,299035185,587209559,102811513,103604117];
for i=1:targetNum
    delete(['.\log\' num2str(idPool(i)) '.log']);
end