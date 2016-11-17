function SendMessage(~,~)
    global cnt;
    global currentTime;
    global data;
    global timeData;
    global t;
    
    currentTime=currentTime+1;
    if currentTime==str2double(timeData{1,cnt})
        disp(data{cnt,1});
        fprintf(t,data{cnt,1});
        cnt=cnt+1;
    end

end

