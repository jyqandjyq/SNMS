function arpaDataStruct = CreateARPADataStruct( arpaData,arpaTimeData,arpaTimeDataLineNo )

num=size(arpaData,1);
cntStruct=1;
cntTime=1;
for i=1: num
    if(i>=arpaTimeDataLineNo(cntTime))
        cntTime=cntTime+1;
    end
    arpaDataStruct(cntStruct).Time=arpaTimeData{1,cntTime-1}{1,1};
    arpaDataStruct(cntStruct). TargetNumber=arpaData{i,1}{1,2};
    arpaDataStruct(cntStruct). TargetDistance=arpaData{i,1}{1,3};
    arpaDataStruct(cntStruct). BearingFromOwnShip=arpaData{i,1}{1,4};
    arpaDataStruct(cntStruct). TargetSpeed=arpaData{i,1}{1,6};
    arpaDataStruct(cntStruct). TargetCourse=arpaData{i,1}{1,7};
    arpaDataStruct(cntStruct). TargetName=arpaData{i,1}{1,12};
    arpaDataStruct(cntStruct). TargetStatus=arpaData{i,1}{1,13};
    arpaDataStruct(cntStruct). UTCTime=arpaData{i,1}{1,15};
    cntStruct=cntStruct+1;
end

