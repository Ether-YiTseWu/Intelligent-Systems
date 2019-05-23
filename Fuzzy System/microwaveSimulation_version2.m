clear;
clc;
%------------------------------------------------------------------------------------------------------------------------------------------------------%
x=-4:0.1:4; y=0:0.1:2; [X,Y]=meshgrid(x,y);     %設定X、Y軸
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = -4:0.1:0; yy = -xx/4;  leng = length(yy);
tempLow_AlphaCut = [yy zeros(1,81-leng)];       %低溫 的模糊集合應變數。(因本題輸入為單點輸入，故應變數等於AlphaCut)

xx1 = -3  :0.1:0; yy1 = (3+xx1)/3;  
xx2 =  0.1:0.1:3; yy2 = (3-xx2)/3;
zero = zeros(1,10);
tempMedium_AlphaCut = [zero yy1 yy2 zero];      %中等溫 的模糊集合應變數。

xx = 0:0.1:4; yy = xx/4;  leng = length(yy);
tempHigh_AlphaCut = [yy zeros(1,81-leng)];      %高溫 的模糊集合應變數。(因本題輸入為單點輸入，故應變數等於AlphaCut)
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 1:0.1:2; yy = -1+xx;
weightHeavy_AlphaCut = [zeros(1,10) yy];        %重 的模糊集合應變數。

xx1 =  0  :0.1:1; yy1 = xx1;  
xx2 =  1.1:0.1:2; yy2 = 2-xx2;
weightMedium_AlphaCut = [yy1 yy2];              %中等重 的模糊集合應變數。

xx = 0:0.1:1; yy =  1-xx;
weightLight_AlphaCut = [yy zeros(1,10)];        %輕 的模糊集合應變數。
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 1000:1200; yy = (-1000+xx)/200;            
powerHigh = [zeros(1,1000) yy];                 %高功率 的模糊集合應變數。

xx1 =  700:900;  yy1 = -700+xx1;  
xx2 =  901:1100; yy2 = 1100-xx2; 
zero = zeros(1,400);
powerMedium = [zero yy1 yy2 zero];              %中等功率 的模糊集合應變數。

xx = 600:800; yy = (800-xx)/200;            
powerLow = [yy zeros(1,1000)];                  %低功率 的模糊集合應變數。
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 5:10; yy = -5+xx;            
op_timeLong = [zeros(1,5) yy];                  %長運轉時間 的模糊集合應變數。

xx1 =  0:5 ; yy1 = xx1/5;  
xx2 =  6:10; yy2 = (10-xx2)/5;            
op_timeMedium = [yy1 yy2];                      %中等運轉時間 的模糊集合應變數。

xx = 0:5; yy = (5-xx)/5;            
op_timeShort = [yy zeros(1,5)];                 %短運轉時間 的模糊集合應變數。
%------------------------------------------------------------------------------------------------------------------------------------------------------%
for i=1:21
     for j=1:81
         temp1 = weightHeavy_AlphaCut(i);
         temp2 = tempLow_AlphaCut(j);
         Rule1_AlphaCut(i,j)=min(temp1,temp2);  %對應規則一，將x和y的每個輸入所得到的AlphaCut做取小運算，共得到21*81筆資料
     end
end

for i=1:21                                                   %將每筆AlphaCut資料與輸出圖形做取小運算，以得到Rule1_powerOutput
     for j=1:81
             numerator = 0;                                              
             denominator = 0;
         for k=600:1200                                      %功率的資料可能有錯，畫出來的圖竟然有0~600W????明明輸出裡沒有這項的
             temp1 = Rule1_AlphaCut(i,j);
             temp2 = powerHigh(k+1);
         
             numerator = numerator + k*min (temp1,temp2);    %min (temp1,temp2)的每一列代表高功率函數與Rule1_AlphaCut的取小運算結果，之後將之做離散化便可得解
             denominator = denominator + min (temp1,temp2);
         end
         Rule1_powerAns(i,j) = numerator/denominator;
     end
end
for i=1:21                                                  
     for j=1:81
         for k=1:11                                        
             numerator = 0;                                              
             denominator = 0;
             temp1 = Rule1_AlphaCut(i,j);
             temp2 = op_timeLong(k);
            
             numerator = numerator + (k-1)*min (temp1,temp2);
             denominator = denominator + min (temp1,temp2);
         end
         Rule1_op_timeAns(i,j) = numerator*denominator;
     end
end
%------------------------------------------------------------------------------------------------------------------------------------------------------%
%subplot(1,2,1); 
surf(X,Y,Rule1_powerAns);     title("Microwave Oven Simalation (Fuzzy Theory)"); xlabel('Temperature(°C)'); ylabel('Weight(kg)'); zlabel('Power(w)');

%subplot(1,2,2); 
%surf(X,Y,Rule1_op_timeAns);   title("Microwave Oven Simalation (Fuzzy Theory)"); xlabel('Temperature(°C)'); ylabel('Weight(kg)'); zlabel('Operation Time(min)');