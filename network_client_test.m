clc
clear all;

global t;
global data;
global timeData;
global cnt;
global currentTime;

t=udp('localhost',8844);
fopen(t);

data=textread('arpa.dat', '%s', 'delimiter', '\n');
data(cellfun(@isempty,data))=[];
timeData=regexp(data,'[0-9]{10}\t\t','match');
timeDataLineNo=find(~cellfun(@isempty,timeData));
timeData=regexp([timeData{:,1}],'[0-9]{10}','match');
timeData(cellfun(@isempty,timeData))=[];
data=regexprep(data,'[0-9]{10}\t\t','');
data=regexprep(data,'\t','');

cnt=1;
currentTime=1468042605;
tm=timer('ExecutionMode','fixedRate');
tm.StartFcn=@(x,y)disp('start sending message');
tm.TimerFcn=@SendMessage;
start(tm);
pause(60);
stop(tm);

fclose(t);
delete(t);