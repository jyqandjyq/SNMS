function [data,timeData,timeDataLineNo] = ImportData(file)

data=textread(file, '%s', 'delimiter', '\n');
data(cellfun(@isempty,data))=[];
timeData=regexp(data,'[0-9]{10}\t\t','match');
timeDataLineNo=find(~cellfun(@isempty,timeData));
timeData=regexp([timeData{:,1}],'[0-9]{10}','match');
timeData(cellfun(@isempty,timeData))=[];
data=regexprep(data,'[0-9]{10}\t\t','');
data=regexprep(data,'\t','');
data=regexp(data,',','split');
