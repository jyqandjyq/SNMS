function aisDataStruct = CreateAISDataStruct(aisData,aisTimeData,aisTimeDataLineNo,type)

aisDataStruct=[];
num=size(aisData,1);
cntStruct=1;
cntTime=1;
aisTimeDataLineNo(end+1)=inf;
for i=1: num
    if(i>=aisTimeDataLineNo(cntTime))
        cntTime=cntTime+1;
    end
    if(~strcmp(aisData{i,1}{1,1},type))
        continue;
    end
%     disp(i);
    if( ( strcmp(aisData{i,1}{1,6}(1),'1') || strcmp(aisData{i,1}{1,6}(1),'2') || strcmp(aisData{i,1}{1,6}(1),'3') ) && aisData{i,1}{1,2}=='1' )
        [MessageID,UserID,NavigationalStatus,ROT,SOG,PositionAcuracy,Longitude,Latitude,COG,TrueHeading,TimeStamp,CommunicationState]=Decode(aisData{i,1}{1,6});
        aisDataStruct(cntStruct).Time=aisTimeData{1,cntTime-1}{1,1};
        aisDataStruct(cntStruct).MessageID=MessageID;
        aisDataStruct(cntStruct).UserID=UserID;
        aisDataStruct(cntStruct).NavigationalStatus=NavigationalStatus;
        aisDataStruct(cntStruct).ROT=ROT;
        aisDataStruct(cntStruct).SOG=SOG;
        aisDataStruct(cntStruct).PositionAcuracy=PositionAcuracy;
        aisDataStruct(cntStruct).Longitude=Longitude;
        aisDataStruct(cntStruct).Latitude=Latitude;
        aisDataStruct(cntStruct).COG=COG;
        aisDataStruct(cntStruct).TrueHeading=TrueHeading;
        aisDataStruct(cntStruct).TimeStamp=TimeStamp;
        aisDataStruct(cntStruct).CommunicationState=CommunicationState;
        cntStruct=cntStruct+1;
    end
end