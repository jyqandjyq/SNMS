function DisposeData()
global aisQueue;
global arpaQueue;
global selfAis;
global arpaData;
global aisData;
global P;

if ~isempty(selfAis)
    while ~isempty(arpaQueue)
        if arpaQueue(1,:).longitude~=181
            if isnan(arpaData(arpaQueue(1).no,:))
                arpaData(arpaQueue(1).no,:)=[arpaQueue(1).longitude arpaQueue(1).latitude arpaQueue(1).speed arpaQueue(1).heading arpaQueue(1).time];
            else
                time=(arpaQueue(1,:).time+arpaData(arpaQueue(1,:).no,5))/2;
                if mod(time,3)==0
                    [B,L] = TransformTime(arpaData(arpaQueue(1).no,1),arpaData(arpaQueue(1).no,2),arpaData(arpaQueue(1).no,5),arpaQueue(1).longitude,arpaQueue(1).latitude,arpaQueue(1).time,time);
                    arpaData(arpaQueue(1).no,:)=[B,L arpaQueue(1).speed arpaQueue(1).heading time];
                else
                    arpaData(arpaQueue(1).no,:)=[arpaQueue(1).longitude arpaQueue(1).latitude arpaQueue(1).speed arpaQueue(1).heading arpaQueue(1).time];
                end
            end
        else
            arpaData(arpaQueue(1).no,:)=nan;
        end
        arpaQueue(1)=[];
    end
    
    while ~isempty(aisQueue)
        arpa=[];
        for i=1:100
            if ~isnan(arpaData(i,1))
                arpa=[arpa;arpaData(i,:)];
            end
        end
        [U,~]=DataLinked([aisQueue(1).longitude aisQueue(1).latitude aisQueue(1).speed aisQueue(1).heading],arpa,2,0.9);
        if ~isnan(U)
            i=find(P(:,1)==aisQueue(1).id);
            if isempty(i)
                P(end+1,1)=aisQueue(1).id;
                i=size(P,1);
                P(end,2)=0;
            end
            [Data,P(i,2)] = Kalman(P(i,2),[aisQueue(1).longitude aisQueue(1).latitude],arpa(U,1:2));
        else
            Data=[aisQueue(1).longitude aisQueue(1).latitude];
        end
        j=find(aisData(:,1)==aisQueue(1).id);
        if ~isempty(j)
            aisData(j,2:5)=[Data aisQueue(1).speed aisQueue(1).heading];
            dlmwrite(['.\log\' num2str(aisQueue(1).id) '.log'],aisData(j,2:3),'-append','precision',7,'newline','pc');
        else
            aisData(end+1,:)=[aisQueue(1).id aisQueue(1).longitude aisQueue(1).latitude aisQueue(1).speed aisQueue(1).heading];
            dlmwrite(['.\log\' num2str(aisQueue(1).id) '.log'],aisData(end,2:3),'-append','precision',7,'newline','pc');
        end
        aisQueue(1)=[];
    end
end