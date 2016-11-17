function TimerFcn(~,~)
global selfAis;
global aisData;
global exit_flag;
global focus_flag;
global focusTarget;
global handle;

startHandle=handle;

while exit_flag==0
    generateData();
    flushFlag=GetData();
    DisposeData();
    if flushFlag
        if ~focus_flag
            cla;
            R0 = GetXY_FromLonAndLat(selfAis.longitude,selfAis.latitude);
            draw_selfship(selfAis.heading,0,0,startHandle);
            for j = 1:size(aisData,1)
                R = GetXY_FromLonAndLat(aisData(j,2),aisData(j,3));
                draw_othership(aisData(j,1),(R(1)-R0(1))/10,(R(2)-R0(2))/10,startHandle);
            end
        else
             cla;
             R0 = GetXY_FromLonAndLat(selfAis.longitude,selfAis.latitude);
             draw_selfship(selfAis.heading,0,0,handle);
             R = GetXY_FromLonAndLat(aisData(focusTarget,2),aisData(focusTarget,3));
            draw_othership(aisData(focusTarget,1),(R(1)-R0(1))/10,(R(2)-R0(2))/10,handle);
        end
    end
%     pause(0.01);
end


end

