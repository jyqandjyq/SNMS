function [B,L] = TransformTime(B1,L1,T1,B2,L2,T2,T)
%output:
%B:latitude in T time
%L:longitude in T time
%intput:
%B1:latitude in T1 time
%L1:longitude in T1 time
%T1:previous time
%B1:latitude in T2 time
%L1:longitude in T2 time
%T2:next time
%T:the time we needed

B=B1*((T2-T)/(T2-T1))+B2*((T-T1)/(T2-T1));
L=L1*((T2-T)/(T2-T1))+L2*((T-T1)/(T2-T1));

end

