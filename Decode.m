function [ MessageID,UserID,NavigationalStatus,ROT,SOG,PositionAcuracy,Longitude,Latitude,COG,TrueHeading,TimeStamp,CommunicationState ] = Decode(String)

load Table_C2.mat
% disp(String);
Massage=nan;
for i=1: length(String)
    Massage(end+1:end+6)=Table_C2(String(i));
end
Massage(1)=[];
MessageID=bin2dec(num2str(Massage(1:6)));
str=num2str(Massage(9:38));
str(isspace(str)) = [];
UserID=bin2dec(str);
NavigationalStatus=bin2dec(num2str(Massage(39:42)));
ROT=bin2dec(num2str(Massage(44:50)))*720/127;
if(Massage(43)==1)
    ROT=-ROT;
end
SOG=bin2dec(num2str(Massage(51:60)))/10;
PositionAcuracy=Massage(61);
str=num2str(Massage(63:89));
str(isspace(str)) = [];
Longitude=bin2dec(str)/10000;
if(Massage(62)==1)
    Longitude=-Longitude;
end
str=num2str(Massage(91:116));
str(isspace(str)) = [];
Latitude=bin2dec(str)/10000;
if(Massage(90)==1)
    Latitude=-Latitude;
end
COG=bin2dec(num2str(Massage(117:128)))/10;
TrueHeading=bin2dec(num2str(Massage(129:137)));
TimeStamp=bin2dec(num2str(Massage(138:143)));
CommunicationState=Massage(150:168);