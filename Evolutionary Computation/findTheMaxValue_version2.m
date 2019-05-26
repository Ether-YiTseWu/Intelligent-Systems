clear;clc;

% x = [-10:0.01:10];    fx = -15*power(sin(2*x),2)-power((x-2),2)+160;
% plot(x,fx);                                                                                        %利用plot大致畫出此題目之圖形                  
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---generate initial generation---%
internal = 20/1023;     x = -10:internal:10;                                                         %題目規定為10bits

B_initialGeneration_decimal = randi(1023,1,10);                                                      %產出初始世代(十進位)    B指binary code
B_initialGeneration_decode = x(B_initialGeneration_decimal);                                         %產出初始世代(解碼後)    B指binary code
B_initialGeneration_binary = dec2bin(B_initialGeneration_decimal);                                   %產出初始世代(二進位)    B指binary code
B_fitnessValue = findFitness(B_initialGeneration_decode);                                            %利用自已寫的function算出適應值

for i=1:10
    R_initialGeneration_decode(i) = -10+(10-(-10))*rand(1,1);                                        %產出初始世代(解碼後)    R指實數
end
R_fitnessValue = findFitness(R_initialGeneration_decode);                                            %算出適應值             R指實數和演化計算法

for i=1:10
    EA_initialGeneration_decode(i) = -10+(10-(-10))*rand(1,1);                                       %產出初始世代(解碼後)    REA指實數和演化計算法
end
EA_fitnessValue = findFitness(EA_initialGeneration_decode);                                          %算出適應值  EA指演化計算法
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---reproduction(initial generation)---%
B_percentage = wheel_percent(B_fitnessValue);       %利用自已寫的function，得到輪盤法後得到的比率(B)
R_percentage = wheel_percent(R_fitnessValue);       %利用自已寫的function輪盤法後得到的比率(R)
EA_percentage = wheel_percent(EA_fitnessValue);     %利用自已寫的function輪盤法後得到的比率(EA)

B_wheelGeneration_decimal = rouletteWheelSelection(B_initialGeneration_decimal,B_percentage);      %利用自已寫的function解出經過輪盤法後得到的值(十進位)(B)
B_tournamentGeneration_decimal = tournamentSelection(B_initialGeneration_decimal,2);               %利用自已寫的function解出經過競爭法後得到的值(十進位)(B)

R_wheelGeneration_decode = rouletteWheelSelection(R_initialGeneration_decode,R_percentage);        %利用自已寫的function解出經過競爭法後得到的值(R)
R_tournamentGeneration_decode = tournamentSelection(R_initialGeneration_decode,2);                 %利用自已寫的function解出經過競爭法後得到的值(R)

EA_wheelGeneration_decode = rouletteWheelSelection(EA_initialGeneration_decode,EA_percentage);     %利用自已寫的function解出經過競爭法後得到的值(EA)
EA_tournamentGeneration_decode = tournamentSelection(EA_initialGeneration_decode,2);               %利用自已寫的function解出經過競爭法後得到的值(EA)
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---crossover---%
n = 1;

while n<501                                                                    %開始進行基因演算法的計算
    b = randperm(10);                                                          %決定交配亂數
    r = randperm(10);                                                          %決定交配亂數
    ea = randperm(10);                                                         %決定交配亂數

    B_wheel_parent = dec2bin(B_wheelGeneration_decimal(b(1:10)));               %決定B型要交配的人口(輪盤法)
    B_tournament_parent = dec2bin(B_tournamentGeneration_decimal(b(1:10)));     %決定B型要交配的人口(競爭法)
    R_wheel_parent = R_wheelGeneration_decode(r(1:8));                         %決定R要交配的人口(輪盤法)
    R_tournament_parent = R_tournamentGeneration_decode(r(1:8));               %決定R要交配的人口(競爭法)
    EA_wheel_parent = EA_wheelGeneration_decode(ea(1:8));                      %決定EA要交配的人口(輪盤法)
    EA_tournament_parent = EA_tournamentGeneration_decode(ea(1:8));            %決定EA要交配的人口(競爭法)

%%%%%%%%%%%%%%%%%------記得寫binary的交配法-------%%%%%%%%%%%%%%%%%%%%%%
    B_wheel_generation = binaryValue_crossover(B_wheel_parent);                 %利用自已寫的function完成B型交配(輪盤法)
    B_wheel_generation = binaryValue_crossover(B_tournament_parent);            %利用自已寫的function完成B型交配(競爭法)
    R_wheel_generation = realValue_crossover(R_wheel_parent);                   %利用自已寫的function完成R型交配(輪盤法)
    R_tournament_generation = realValue_crossover(R_tournament_parent);         %利用自已寫的function完成R型交配(競爭法)
    EA_wheel_generation = evoAlgorithm_crossover(EA_wheel_parent);              %利用自已寫的function完成EA型交配(輪盤法)
    EA_tournament_generation = evoAlgorithm_crossover(EA_tournament_parent);    %利用自已寫的function完成EA型交配(競爭法)


    R_wheel_generation(9:10) = R_wheelGeneration_decode(r(9:10));               
    R_tournament_generation(9:10) = R_tournamentGeneration_decode(r(9:10));
    EA_wheel_generation(9:10) = EA_wheelGeneration_decode(ea(9:10));
    EA_tournament_generation(9:10) = EA_tournamentGeneration_decode(ea(9:10));   %左邊四行程式碼為：將沒有進行交配的人口加回族群中
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---mutation---%
    if mod(n,10) == 0
        R_wheel_generation = R_mutation(R_wheel_generation);                    %利用已寫的function得出R型的突變結果(輪盤法)
        R_tournament_generation = R_mutation(R_tournament_generation);          %利用已寫的function得出R型的突變結果(競爭法)           
        EA_wheel_generation = EA_mutation(EA_wheel_generation);                 %利用已寫的function得出EA型的突變結果(輪盤法)
        EA_tournament_generation = EA_mutation(EA_tournament_generation);       %利用已寫的function得出EA型的突變結果(競爭法)
    end                                                                         
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---cuculate and reproduction---%
    R_wheelFit = findFitness(R_wheel_generation);         %求出適應值(輪盤法，實數型)
    R_tourFit = findFitness(R_tournament_generation);     %求出適應值(競爭法，實數型)
    EA_wheelFit = findFitness(EA_wheel_generation);       %求出適應值(輪盤法，EA型)
    EA_tourFit = findFitness(EA_tournament_generation);   %求出適應值(競爭法，EA型)
    
    NEW_R_wheelPercentage = wheel_percent(R_wheelFit);
    NEW_R_wheelGeneration_decode = rouletteWheelSelection(R_wheel_generation,NEW_R_wheelPercentage);             %reproduction(輪盤法，實數型)
    NEW_EA_wheelPercentage = wheel_percent(EA_wheelFit);
    NEW_EA_wheelGeneration_decode = rouletteWheelSelection(EA_wheel_generation,NEW_EA_wheelPercentage);          %reproduction(輪盤法，EA型)
    
    NEW_R_tourGeneration_decode = tournamentSelection(R_tournament_generation,2);                                %reproduction(競爭法，實數型)
    NEW_EA_tourGeneration_decode = tournamentSelection(EA_tournament_generation,2);                              %reproduction(競爭法，EA型)
    
    R_wheelGeneration_decode = NEW_R_wheelGeneration_decode;                              %更新值，以使迴圈執行無誤(輪盤法，實數型)
    R_tournamentGeneration_decode = NEW_R_tourGeneration_decode;                          %更新值，以使迴圈執行無誤(競爭法，實數型)
    EA_wheelGeneration_decode = NEW_EA_wheelGeneration_decode;                            %更新值，以使迴圈執行無誤(輪盤法，EA型)
    EA_tournamentGeneration_decode = NEW_EA_tourGeneration_decode;                        %更新值，以使迴圈執行無誤(競爭法，EA型)
    
    R_wheel_plot(n) = max(R_wheelFit);                                                    %紀錄此次世代的最佳解(輪盤法，實數型)
    R_tour_plot(n) = max(R_tourFit);                                                      %紀錄此次世代的最佳解(競爭法，實數型)
    EA_wheel_plot(n) = max(EA_wheelFit);                                                  %紀錄此次世代的最佳解(輪盤法，EA型)
    EA_tour_plot(n) = max(EA_tourFit);                                                    %紀錄此次世代的最佳解(競爭法，EA型)
    
    n = n + 1;
end
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---plot---%
xx = 1:n-1; 

R_wheel_ans = power(R_wheel_plot(n-1),0.0625);         %找到最新世代的適應值，之後解碼(輪盤法，實數型)
R_tour_ans = power(R_tour_plot(n-1),0.0625);           %找到最新世代的適應值，之後解碼(競爭法，實數型)
EA_wheel_ans = power(EA_wheel_plot(n-1),0.0625);       %找到最新世代的適應值，之後解碼(輪盤法，EA型)
EA_tour_ans = power(EA_tour_plot(n-1),0.0625);         %找到最新世代的適應值，之後解碼(競爭法，EA型)

subplot(3,2,3);
plot(xx,R_wheel_plot); title( {['Real-Value GAs with roulette wheel selection'],['Maximum = ' , mat2str(R_wheel_ans)]});  
xlabel('Generations'); ylabel('Fitness');
subplot(3,2,4);
plot(xx,R_tour_plot); title( {['Real-Value GAs with tournament selection'],['Maximum = ' , mat2str(R_tour_ans)]});  
xlabel('Generations'); ylabel('Fitness');           
subplot(3,2,5);
plot(xx,EA_wheel_plot); title( {['Evolutionary Algorithm with roulette wheel selection'],['Maximum = ' , mat2str(EA_wheel_ans)]});  
xlabel('Generations'); ylabel('Fitness');
subplot(3,2,6);
plot(xx,EA_tour_plot); title( {['Evolutionary Algorithm with tournament selection'],['Maximum = ' , mat2str(EA_tour_ans)]});  
xlabel('Generations'); ylabel('Fitness');           