clear all
clc

% global realData;
% global arpaTarget;
% global aisTarget;
% global aisData;
% global Time;
% global p;
% global aisT;
% global arpaT;
% global Arpa;
% global strT;
% p=[];
% aisT=[];
% arpaT=[];
% Arpa=[];
% strT=cell(0,0);

% Initialize();
% data=[];
% arpa=[];
% ais=[];
% realData=[];
% arpaError=zeros(100,1);
% aisError=zeros(100,1);
% dataError=zeros(100,1);

% for i=1:100
%     generateData();
%     flushFlag=GetData();
%     DisposeData();
%     if mod(Time-1,2)==0
%         arpa=[arpa;arpaTarget];
%         arpaError(i)=norm(arpa(end,:)-realData(end,:));
%     end
%     if mod(Time-1,3)==0
%         ais=[ais;aisTarget(1:2)];
%         aisError(i)=norm(ais(end,:)-realData(end,:));
%         data=[data;aisData(2:3)];
%         dataError(i)=norm(data(end,:)-realData(end,:));
%     end
% end

mile=1852;
aisEroor=5/mile/60;
arpaEroor=8/mile/60;

target(4)=rand*360;
target(1:2)=rand(1,2)*180;
target(3)=10+rand*5;
target(7)=0.99+rand*0.02;

arpa=[];
ais=[];
realData=[];
data=[];
arpaError=zeros(1000,1);
aisError=zeros(1000,1);
dataError=zeros(1000,1);
for i=1:1000
    target(4)=target(4)*target(7);
    [target(1),target(2)]=Radar2Geodetic(target(1),target(2),target(3)*(1/360),target(4));
    for j=1:2
        if rand<0.5
            arpaTarget(1)=target(1)+arpaEroor+arpaEroor*wgn(1,1,-30);
        else
            arpaTarget(1)=target(1)-arpaEroor+arpaEroor*wgn(1,1,-30);
        end
        if rand<0.5
            arpaTarget(2)=target(2)+arpaEroor+arpaEroor*wgn(1,1,-30);
        else
            arpaTarget(2)=target(2)-arpaEroor+arpaEroor*wgn(1,1,-30);
        end
        
        if rand<0.5
            aisTarget(1)=target(1)+aisEroor+aisEroor*wgn(1,1,-30);
        else
            aisTarget(1)=target(1)-aisEroor+aisEroor*wgn(1,1,-30);
        end
        if rand<0.5
            aisTarget(2)=target(2)+aisEroor+aisEroor*wgn(1,1,-30);
        else
            aisTarget(2)=target(2)-aisEroor+aisEroor*wgn(1,1,-30);
        end
    end
    arpa=[arpa;arpaTarget];
    ais=[ais;aisTarget];
    realData=[realData;target(1:2)];
    arpaError(i)=norm(arpa(end,:)-realData(end,:));
    aisError(i)=norm(ais(end,:)-realData(end,:));
end

Q=0.005;
R=1;
P=0;
for i=1:1000
    A1=ais(i,:);
    A2=arpa(i,:);
    P0=P+Q;

    Kg=P0/(P0+R);
    Data=A1+Kg*(A2-A1);
    P=(1-Kg)*P0;
    data=[data;Data];
    dataError(i)=norm(data(end,:)-realData(i,:));
end

% figure
% plot(arpa(:,1)',arpa(:,2)','green');
% hold on
% plot(ais(:,1)',ais(:,2)','blue');
% hold on
% plot(data(:,1)',data(:,2)','black');
% hold on
% plot(realData(:,1)',realData(:,2)','red');
% hold on

arpaError=arpaError*mile*60;
aisError=aisError*mile*60;
dataError=dataError*mile*60;

figure(1)
x=1:1000;
plot(x,dataError,'green');
hold on
% plot(x,arpaError,'red');
% hold on
plot(x,aisError,'blue');
hold off

arpaErrorSum=sum(arpaError);
aisErrorSum=sum(aisError);
dataErrorSum=sum(dataError);
arpaErrorMean=arpaErrorSum/size(arpa,1);
aisErrorMean=aisErrorSum/size(ais,1);
dataErrorMean=dataErrorSum/size(data,1);
disp(['arpa error mean=' num2str(arpaErrorMean)]);
disp(['ais error mean=' num2str(aisErrorMean)]);
disp(['data error mean=' num2str(dataErrorMean)]);
disp(['ais increase percent=' num2str(100*(aisErrorMean-dataErrorMean)/aisErrorMean)]);
disp(['arpa increase percent=' num2str(100*(arpaErrorMean-dataErrorMean)/arpaErrorMean)]);