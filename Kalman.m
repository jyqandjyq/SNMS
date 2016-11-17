function [Data,P] = Kalman(P,aisData,arpaData)

Q=0.0001;          %AIS��˹��������covariance
R=1;          %ARPA��˹��������covariance
        
A1=aisData;     %AIS������ΪϵͳԤ��ֵ
A2=arpaData;  %ARPA������Ϊ�۲�ֵ 
P0=P+Q;

Kg=P0/(P0+R);                      %����������
Data=A1+Kg*(A2-A1);          %�ں�����
P=(1-Kg)*P0;                         %ARPA��˹��������covariance����