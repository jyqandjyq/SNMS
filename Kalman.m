function [Data,P] = Kalman(P,aisData,arpaData)

Q=0.0001;          %AIS高斯白噪声的covariance
R=1;          %ARPA高斯白噪声的covariance
        
A1=aisData;     %AIS数据作为系统预测值
A2=arpaData;  %ARPA数据作为观测值 
P0=P+Q;

Kg=P0/(P0+R);                      %卡尔曼增益
Data=A1+Kg*(A2-A1);          %融合数据
P=(1-Kg)*P0;                         %ARPA高斯白噪声的covariance更新