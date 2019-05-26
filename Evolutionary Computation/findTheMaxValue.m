clear;clc;

% x = [-10:0.01:10];    fx = -15*power(sin(2*x),2)-power((x-2),2)+160;
% plot(x,fx);                                                                                                                 %利用plot大致畫出此題目之圖形                  
%-----------------------------------------------------------------------------------------------------------------------------------------------------%
internal = 20/1023;     x = -10:internal:10;                                                                                %題目規定為10bits

B_initialGeneration_decimal = randi(1023,1,10);                                                                             %產出初始世代(十進位)    B指binary code
B_initialGeneration_decode = x(B_initialGeneration_decimal);                                                                %產出初始世代(解碼後)    B指binary code
B_initialGeneration_binary = dec2bin(B_initialGeneration_decimal);                                                          %產出初始世代(二進位)    B指binary code
B_fitnessValue = power( (-15*power(sin(2*B_initialGeneration_decode),2)-power((B_initialGeneration_decode-2),2)+160) ,2);   %算出適應值

for i=1:10
    REA_initialGeneration_decode(i) = -10+(10-(-10))*rand(1,1);                                                                 %產出初始世代(解碼後)    REA指實數和演化計算法
end
REA_fitnessValue = power( (-15*power(sin(2*REA_initialGeneration_decode),2)-power((REA_initialGeneration_decode-2),2)+160) ,2); %算出適應值             REA指實數和演化計算法
%-----------------------------------------------------------------------------------------------------------------------------------------------------%
B_percentage = wheel_percent(B_fitnessValue);           %利用自已寫的function輪盤法後得到的比率(B)
REA_percentage = wheel_percent(REA_fitnessValue);       %利用自已寫的function輪盤法後得到的比率(REA)

B_wheelGeneration_decimal = rouletteWheelSelection(B_initialGeneration_decimal,B_percentage);          %利用自已寫的function解出經過輪盤法後得到的值(十進位)(B)
B_tournamentGeneration_decimal = tournamentSelection(B_initialGeneration_decimal,2);                   %利用自已寫的function解出經過競爭法後得到的值(十進位)(B)

REA_wheelGeneration_decode = rouletteWheelSelection(REA_initialGeneration_decode,REA_percentage);      %利用自已寫的function解出經過競爭法後得到的值(REA)
REA_tournamentGeneration_decode = tournamentSelection(REA_initialGeneration_decode,2);                 %利用自已寫的function解出經過競爭法後得到的值(REA)
%-----------------------------------------------------------------------------------------------------------------------------------------------------%
b = randperm(10);                                                          %決定交配亂數

B_wheel_parent = B_wheelGeneration_decimal(b(1:8));                        %決定二進位型要交配的人口(輪盤法)
B_tournament_parent = B_tournamentGeneration_decimal(b(1:8));              %決定二進位型要交配的人口(競爭法)
REA_wheel_parent = REA_wheelGeneration_decode(b(1:8));                     %決定REA要交配的人口(輪盤法)
REA_tournament_parent = REA_tournamentGeneration_decode(b(1:8));           %決定REA要交配的人口(競爭法)

REA_wheel_notparent = REA_wheelGeneration_decode(b(9:10));                 %紀錄REA沒有交配的人口(輪盤法)
REA_tournament_notparent = REA_tournamentGeneration_decode(b(9:10));       %紀錄REA沒有交配的人口(競爭法)

%%%%%%%%%%%%%%%%%------記得寫binary的交配法-------%%%%%%%%%%%%%%%%%%%%%%

R_wheel_generation = realValue_crossover(REA_wheel_parent);                %利用自已寫的function完成實數型交配(輪盤法)
R_tournament_generation = realValue_crossover(REA_tournament_parent);      %利用自已寫的function完成實數型交配(競爭法)
EA_wheel_generation = evoAlgorithm_crossover(REA_wheel_parent);            %利用自已寫的function完成EA型交配(輪盤法)
EA_tournament_generation = evoAlgorithm_crossover(REA_tournament_parent);  %利用自已寫的function完成EA型交配(競爭法)

R_wheel_generation(9:10) = REA_wheel_notparent;
R_tournament_generation(9:10) = REA_tournament_notparent;
EA_wheel_generation(9:10) = REA_wheel_notparent;
EA_tournament_generation(9:10) = REA_tournament_notparent;                 %將沒有交配的重新加入population中，46~49行為經過交配後的世代們
%-----------------------------------------------------------------------------------------------------------------------------------------------------%
n = 1;
while n<501
    for i=1:10
        R_wheelFit(i) = power( (-15*power(sin(2*R_wheel_generation(i)),2)-power((R_wheel_generation(i)-2),2)+160) ,2);     %求出適應值(輪盤法，實數型)
    end
    R_wheel_plot(n) = max(R_wheelFit);
    
    NEW_R_percentage = wheel_percent(R_wheelFit);
    NEW_R_wheelGeneration_decode = rouletteWheelSelection(R_wheel_generation,NEW_R_percentage);     %reproduction
    b = randperm(10);
    NEW_R_wheel_parent = NEW_R_wheelGeneration_decode(b(1:8));
    NEW_R_wheel_generation = realValue_crossover(NEW_R_wheel_parent);                               
    NEW_R_wheel_generation(9:10) = NEW_R_wheelGeneration_decode(b(9:10));                           %crossover
    
%     if mod(n,100) == 0
%         for i=1:10
%             randN(i) = -10+(10-(-10))*rand(1,1);                                                              
%         end
%         NEW_R_wheel_generation = NEW_R_wheel_generation + randN;                                    %加入mutation後，變得怪怪的              
%     end
    
    R_wheel_generation = NEW_R_wheel_generation;
    
    n = n + 1;
end

ANS_R_wheel = power (R_wheel_plot(500),0.5);
xx = 1:n-1; 
plot(xx,R_wheel_plot); title(ANS_R_wheel);