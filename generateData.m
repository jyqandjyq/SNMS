function generateData()
global Time;
global message;
global selfB;
global selfL;
global target;
global arpaTargetNo;
global aisTargetId;
global targetNum;
global realData;
global arpaTarget;
global aisTarget;

aisEroor=5;                    %ais error/m
arpaEroor=10;                 %arpa eroor/m

speed=1;
heading=30;
mile=1852;
aisEroor=aisEroor/mile/60;
arpaEroor=arpaEroor/mile/60;

idPool=[874802897,972586686,136351055,980729857,678990570,104733212,299035185,587209559,102811513,103604117];

message=[];

if mod(Time,3)==0
    message=[message;0 0 selfB selfL speed heading Time];
end

for i=1:targetNum
    target(i,4)=target(i,4)*target(i,7);
    [target(i,1),target(i,2)]=Radar2Geodetic(target(i,1),target(i,2),target(i,3)*(1/3600),target(i,4));
    arpaTarget=target(i,1:2)+arpaEroor*randn(1,2);
    [x0,y0,z0]=TransformXYZ(selfB,selfL);
    [x2,y2,z2]=TransformXYZ(selfB,selfL+1/3600);
    yi=[x2-x0, y2-y0, z2-z0];
    A=yi./((yi(1)^2+yi(2)^2+yi(3)^2)^0.5);        
    [x1,y1,z1]=TransformXYZ(arpaTarget(1),arpaTarget(2));
    B=[x1-x0, y1-y0, z1-z0];
    bearing=rad2deg(acos((A*B')/(norm(B)*norm(A))));
    d=norm(B)/mile;
    if mod(Time,2)==0 && d<20
        no=find(arpaTargetNo==i,1);
        if isempty(no)
            index=1;
            while index<=targetNum && ~isnan(arpaTargetNo(index))
                index=index+1;
            end
            if index<=100
                no=index;
                arpaTargetNo(index)=i;
            else
                no=nan;
            end
        end
        if ~isnan(no)
            arpaData=[arpaTarget(1) arpaTarget(2) target(i,3)+0.1*wgn(1,1,-10) target(i,4)+1*wgn(1,1,-10)];
            message=[message;1 no-1 arpaData Time];
        end
    elseif mod(Time,2)==0 && d>=20
        no=find(arpaTargetNo==i,1);
        if ~isempty(no)
            arpaTargetNo(no)=nan;
            message=[message;1 no-1 181 0 0 0 0];
        end            
    end
    if mod(Time,3)==0
        aisTarget=[target(i,1:2)+aisEroor*randn(1,2) target(i,3)+0.01*randn target(i,4)+0.1*randn];
        if aisTargetId(i)~=0
            id=aisTargetId(i);
        else
            id=idPool(i);
            aisTargetId(i)=idPool(i);
        end
        message=[message;2 id aisTarget Time];
    end
         realData=[realData;target(i,1:2)];
end

Time=Time+1;
