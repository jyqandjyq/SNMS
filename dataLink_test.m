clear all;
clc

ais=[51    60   1   45];

arpa=[100  100    1   30;
            20    20     1   30;
            50    60     1   45];
[U,V]=DataLinked(ais,arpa,2,0.99);