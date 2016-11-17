% function message = GenerateArpaMessage(data,time)
time=14234;
data=[02,1.23,227.7,0.2,62.6,1.20,-2.7];

str=['$RATTM,' num2str(data(1),'%2.0f,') num2str(data(2),'%1.2f,') num2str(data(3),'%3.1f,T,') num2str(data(4),'%1.1f,') num2str(data(5),'%2.1f,T,') num2str(data(6),'%1.2f,') num2str(data(7),'%1.1f,') num2str(time)];