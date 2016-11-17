clc
t=udp('localhost','Localport',8844);
fopen(t);
fp1 = fopen('log.txt','wt');
while 1
    [data,count,~]=fscanf(t,'%s');
    if count>0
        fprintf(fp1, '%s\n', data);
    else
        break;
    end
end
fclose(t);
delete(t);