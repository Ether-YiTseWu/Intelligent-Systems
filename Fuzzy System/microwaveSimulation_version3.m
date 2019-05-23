clear;
clc;                                            %初始化
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = -4:0.1:0; yy = -xx/4;  leng = length(yy);
tempLow_AlphaCut = [yy zeros(1,81-leng)];       %低溫 的模糊集合應變數。(因本題輸入為單點輸入，故應變數等於AlphaCut)

xx1 = -3  :0.1:0; yy1 = (3+xx1)/3;  
xx2 =  0.1:0.1:3; yy2 = (3-xx2)/3;
zero = zeros(1,10);
tempMedium_AlphaCut = [zero yy1 yy2 zero];      %中等溫 的模糊集合應變數。

xx = 0:0.1:4; yy = xx/4;  leng = length(yy);
tempHigh_AlphaCut = [zeros(1,81-leng) yy];      %高溫 的模糊集合應變數。(因本題輸入為單點輸入，故應變數等於AlphaCut)

% plot(x,tempLow_AlphaCut,'b');
% hold on;
% plot(x,tempMedium_AlphaCut,'g');              %繪製題目所給的溫度圖形
% hold on;
% plot(x,tempHigh_AlphaCut,'red');
% hold on;
% legend('tempLow','tempMedium','tempHigh');  xlabel('X:Temperature(°C)');   ylabel('Y:Degree of Membership');
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 1:0.1:2; yy = -1+xx;
weightHeavy_AlphaCut = [zeros(1,10) yy];        %重 的模糊集合應變數。

xx1 =  0  :0.1:1; yy1 = xx1;  
xx2 =  1.1:0.1:2; yy2 = 2-xx2;
weightMedium_AlphaCut = [yy1 yy2];              %中等重 的模糊集合應變數。

xx = 0:0.1:1; yy =  1-xx;
weightLight_AlphaCut = [yy zeros(1,10)];        %輕 的模糊集合應變數。

% plot(y,weightLight_AlphaCut,'b');
% hold on;
% plot(y,weightMedium_AlphaCut,'g');            %繪製題目所給的重量圖形
% hold on;
% plot(y,weightHeavy_AlphaCut,'red');
% hold on;
% legend('weightLight','weightMedium','weightHeavy');  xlabel('X:Weight(Kg)');   ylabel('Y:Degree of Membership');
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 1000:1200; yy = (-1000+xx)/200;            
powerHigh = [zeros(1,400) yy];                 %高功率 的模糊集合應變數。

xx1 =  700:900;  yy1 = (-700+xx1)/200;  
xx2 =  901:1100; yy2 = (1100-xx2)/200; 
zero = zeros(1,100);
powerMedium = [zero yy1 yy2 zero];             %中等功率 的模糊集合應變數。

xx = 600:800; yy = (800-xx)/200;    
powerLow = [yy zeros(1,400)];                  %低功率 的模糊集合應變數。

% tempX = 600:1200; 
% plot(tempX,powerLow,'b');
% hold on;
% plot(tempX,powerMedium,'g');                 %繪製題目所給的功率圖形
% hold on;
% plot(tempX,powerHigh,'red');
% hold on;
% legend('powerLow','powerMedium','powerHigh');  xlabel('X:Power(w)');   ylabel('Y:Degree of Membership');
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 5:10; yy = (-5+xx)/5;            
op_timeLong = [zeros(1,5) yy];                  %長運轉時間 的模糊集合應變數。

xx1= 0:5 ; yy1 = xx1/5;  
xx2= 6:10; yy2 = (10-xx2)/5;            
op_timeMedium = [yy1 yy2];                      %中等運轉時間 的模糊集合應變數。

xx = 0:5; yy = (5-xx)/5;            
op_timeShort = [yy zeros(1,5)];                 %短運轉時間 的模糊集合應變數。

% tempX = 0:10; 
% plot(tempX,op_timeLong,'red');
% hold on;
% plot(tempX,op_timeMedium,'g');                %繪製題目所給的運轉時間圖形
% hold on;
% plot(tempX,op_timeShort,'b');
% hold on;
% legend('Operation Time Long','Operation Time Medium','Operation Time Short');  xlabel('X:Time(min)');   ylabel('Y:Degree of Membership');
%------------------------------------------------------------------------------------------------------------------------------------------------------%
Rule1_AlphaCut   =  RealAlphaCut(weightHeavy_AlphaCut ,tempLow_AlphaCut);
Rule2_AlphaCut   =  RealAlphaCut(weightMedium_AlphaCut,tempLow_AlphaCut);
Rule3_AlphaCut   =  RealAlphaCut(weightLight_AlphaCut ,tempLow_AlphaCut);
Rule4_AlphaCut   =  RealAlphaCut(weightHeavy_AlphaCut ,tempMedium_AlphaCut);
Rule5_AlphaCut   =  RealAlphaCut(weightMedium_AlphaCut,tempMedium_AlphaCut);       
Rule6_AlphaCut   =  RealAlphaCut(weightLight_AlphaCut ,tempMedium_AlphaCut);
Rule7_AlphaCut   =  RealAlphaCut(weightHeavy_AlphaCut ,tempHigh_AlphaCut);
Rule8_AlphaCut   =  RealAlphaCut(weightMedium_AlphaCut,tempHigh_AlphaCut);
Rule9_AlphaCut   =  RealAlphaCut(weightLight_AlphaCut ,tempHigh_AlphaCut);          %利用已寫的函數解Rule1~Rule9對應的AlphaCut 

Rule1_powerAns   =  PowerAns(Rule1_AlphaCut,powerHigh);
Rule2_powerAns   =  PowerAns(Rule2_AlphaCut,powerHigh);
Rule3_powerAns   =  PowerAns(Rule3_AlphaCut,powerHigh);
Rule4_powerAns   =  PowerAns(Rule4_AlphaCut,powerMedium);
Rule5_powerAns   =  PowerAns(Rule5_AlphaCut,powerMedium);
Rule6_powerAns   =  PowerAns(Rule6_AlphaCut,powerMedium);
Rule7_powerAns   =  PowerAns(Rule7_AlphaCut,powerLow);
Rule8_powerAns   =  PowerAns(Rule8_AlphaCut,powerLow);
Rule9_powerAns   =  PowerAns(Rule9_AlphaCut,powerLow);                              %利用已寫的函數使AlphaCut與Rule1~Rule9的功率圖形做取小運算。
powerAns = max(Rule1_powerAns,Rule2_powerAns);
powerAns = max(powerAns,Rule3_powerAns);
powerAns = max(powerAns,Rule4_powerAns);
powerAns = max(powerAns,Rule5_powerAns);
powerAns = max(powerAns,Rule6_powerAns);
powerAns = max(powerAns,Rule7_powerAns);
powerAns = max(powerAns,Rule8_powerAns);
powerAns = max(powerAns,Rule9_powerAns);                                            %利用已寫的函數使Rule1~Rule9對應的所有功率輸出圖形做取大運算。

Rule1_op_timeAns =  OperationTimeAns(Rule1_AlphaCut,op_timeLong);
Rule2_op_timeAns =  OperationTimeAns(Rule2_AlphaCut,op_timeMedium);
Rule3_op_timeAns =  OperationTimeAns(Rule3_AlphaCut,op_timeShort);
Rule4_op_timeAns =  OperationTimeAns(Rule4_AlphaCut,op_timeLong);
Rule5_op_timeAns =  OperationTimeAns(Rule5_AlphaCut,op_timeMedium);
Rule6_op_timeAns =  OperationTimeAns(Rule6_AlphaCut,op_timeShort);
Rule7_op_timeAns =  OperationTimeAns(Rule7_AlphaCut,op_timeLong);
Rule8_op_timeAns =  OperationTimeAns(Rule8_AlphaCut,op_timeMedium);
Rule9_op_timeAns =  OperationTimeAns(Rule9_AlphaCut,op_timeShort);                  %利用已寫的函數使AlphaCut與Rule1~Rule9的運轉時間圖形做取小運算。
op_timeAns = max(Rule1_op_timeAns,Rule2_op_timeAns);
op_timeAns = max(op_timeAns,Rule3_op_timeAns);
op_timeAns = max(op_timeAns,Rule4_op_timeAns);
op_timeAns = max(op_timeAns,Rule5_op_timeAns);
op_timeAns = max(op_timeAns,Rule6_op_timeAns);
op_timeAns = max(op_timeAns,Rule7_op_timeAns);
op_timeAns = max(op_timeAns,Rule8_op_timeAns);
op_timeAns = max(op_timeAns,Rule9_op_timeAns);                                      %利用已寫的函數使Rule1~Rule9對應的所有運轉時間輸出圖形做取大運算。
%------------------------------------------------------------------------------------------------------------------------------------------------------%
x=-4:0.1:4; y=0:0.1:2; [X,Y]=meshgrid(x,y);     %設定X、Y軸

colormap jet;
surf(X,Y,powerAns);     shading interp; colorbar;   title("Microwave Oven Simalation (Fuzzy Theory)"); xlabel('X:Temperature(°C)'); ylabel('Y:Weight(kg)'); zlabel('Power(w)');
%surf(X,Y,op_timeAns);   shading interp; colorbar;   title("Microwave Oven Simalation (Fuzzy Theory)"); xlabel('X:Temperature(°C)'); ylabel('Y:Weight(kg)'); zlabel('Operation Time(min)');