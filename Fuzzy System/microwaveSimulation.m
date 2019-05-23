clear;
clc;

x=-4:0.1:4; y=0:0.1:2; [X,Y]=meshgrid(x,y);     %設定X、Y軸

xx = -4:0.1:0; yy = -xx/4;  leng = length(yy);
tempLow_AlphaCut = [yy zeros(1,81-leng)];       %低溫 的模糊集合應變數。(因本題輸入為單點輸入，故應變數等於AlphaCut)

xx = 1:0.1:2; yy = -1+xx;
weightHeavy_AlphaCut = [zeros(1,10) yy];        %重 的模糊集合應變數。

xx = 1000:1200; yy = (-1000+xx)/200;            %高功率 的模糊集合應變數。
powerHigh = [zeros(1,1000) yy];

for i=1:21
     for j=1:81
         Rule1_AlphaCut(i,j)=min(weightHeavy_AlphaCut(i),tempLow_AlphaCut(j));  %對應規則一，將x和y的每個輸入所得到的AlphaCut做取小運算，共得到21*81筆資料
     end
end

for i=1:21
     for j=1:81
         for k=1:1201
             temp = Rule1_AlphaCut(i,j);
             Rule1_powerOutput(i*j,k) = min (temp,powerHigh(k));    %Rule1_powerOutput的每一列代表高功率函數與Rule1_AlphaCut的取小運算結果，之後將之做離散化便可得解
         end
     end
end

for i=1:1701
    for j=1:1201
        numerator = 0;                                              %21~38行有錯，3/30再來改吧。 第二十五行肯定有問題。為什麼Rule1_powerOutput的值全部都是零。
        denominator = 0;
        numerator = numerator + j*Rule1_powerOutput(i,j);
        denominator = denominator + Rule1_powerOutput(i,j);
    end
    Rule1_powerAns(i) = numerator/denominator;
end

for i=1:21
    for j=1:81
        for k=1:1701
            Rule1_powerAns_(i,j) = Rule1_powerAns(k);
        end
    end
end

surf(X,Y,Rule1_AlphaCut);