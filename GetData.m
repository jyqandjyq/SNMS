function flushFlag = GetData()
global aisQueue;
global arpaQueue;
global selfAis;
global message;

flushFlag=0;
if isempty(message)
    return
end
for i=1:size(message,1)
    data=message(i,:);
    if data(1)==2
        aisData.id=data(2);
        aisData.longitude=data(3);
        aisData.latitude=data(4);
        aisData.speed=data(5);
        aisData.heading=data(6);
        aisData.time=data(7);
        aisQueue=[aisQueue;aisData];
    end
    if data(1)==0
        flushFlag=1;
        selfAisData.longitude=data(3);
        selfAisData.latitude=data(4);
        selfAisData.speed=data(5);
        selfAisData.heading=data(6);
        selfAisData.time=data(7);
        selfAis=selfAisData;
    end
    if data(1)==1
        arpaData.no=data(2)+1;
        arpaData.longitude=data(3);
        arpaData.latitude=data(4);
        arpaData.speed=data(5);
        arpaData.heading=data(6);
        arpaData.time=data(7);
        arpaQueue=[arpaQueue;arpaData];
    end
end

