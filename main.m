clc;
clear all;

[aisData,aisTimeData,aisTimeDataLineNo]=ImportData('ais.dat');
aisData=CreateAISDataStruct(aisData,aisTimeData,aisTimeDataLineNo,'!AIVDM');
save aisData aisData;
selfAISData=CreateAISDataStruct(aisData,aisTimeData,aisTimeDataLineNo,'!AIVDO');
save selfAISData selfAISData;

[arpaData,arpaTimeData,arpaTimeDataLineNo]=ImportData('arpa.dat');
arpaData=CreateARPADataStruct(arpaData,arpaTimeData,arpaTimeDataLineNo);
save arpaData arpaData;