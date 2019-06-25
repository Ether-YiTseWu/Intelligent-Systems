clc; clear;
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---------設定圖形的x,y,z------------%
interval = 1.5/21;                               
x = -0.8+interval : interval :0.7-interval;             %設定x軸數值
y = -0.8+interval : interval :0.7-interval;             %設定y軸數值
for i=1:20                                              %設定z軸數值 
    for j=1:20
        z(i,j) = 5*sin(pi*x(i)^2)*sin(2*pi*y(j))+1; 
    end
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---------得到訓練集----------%
temp = 1;
for i=1:20:381
    source(i:i+19,1) = x(temp);                     
    temp = temp + 1;
end
for i=1:400
    temp = mod(i,20);
    if temp ~=0
        source(i,2) = x(temp);
    else
        source(i,2) = x(20);
    end
end                                                 %做準備以切分，source為每個x和y交集出來的結果
index_train = sort(randperm(400,300));              %設定亂數INDEX(訓練集)
train_x = getTrainAndTest(source,index_train,300,1);%利用已寫好的function切分訓練集部分的x資料
train_y = getTrainAndTest(source,index_train,300,2);%利用已寫好的function切分訓練集部分的y資料
for i=1:300
    train_z(i) = 5*sin(pi*train_x(i)^2)*sin(2*pi*train_y(i))+1;
end                                                                                    %切分訓練集
train_z_encode = (train_z-min(train_z))/(max(train_z)-min(train_z))*(0.8-0.2)+0.2;     %將期望值正規化至0.2~0.8的數值(訓練集)
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---------得到測試集----------%
index_test_temp = 1:400;    
for i = 1:300
    for j = 1:400
        if index_test_temp(j) == index_train(i)
            index_test_temp(j) = 0;
        end
    end
end                                                
temp = 1;
for i = 1:400
    if index_test_temp(i) ~= 0
        index_test(temp) = index_test_temp(i);
        temp = temp + 1;
    end
end                                                                                    %設定亂數INDEX(訓練集)
test_x = getTrainAndTest(source,index_test,100,1);                                     %利用已寫好的function切分測試集部分的x資料
test_y = getTrainAndTest(source,index_test,100,2);                                     %利用已寫好的function切分測試集部分的y資料
for i=1:100
    test_z(i) = 5*sin(pi*test_x(i)^2)*sin(2*pi*test_y(i))+1;
end                                                                                    %切分測試集
test_z_encode = (test_z-min(test_z))/(max(test_z)-min(test_z))*(0.8-0.2)+0.2;          %將期望值正規化至0.2~0.8的數值(訓練集)
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------設定隱藏層數目及學習速度-----------------%
hiddenLayerNum = 10;   learningRate = 5;     learningRate_bias = learningRate;
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------選出隱藏層權重W，並加入bias-----------------%
for i = 1:hiddenLayerNum
    for j = 1:3
        hidden_w(i,j) = -0.5+(0.5-(-0.5))*rand(1,1);                            %hiddenLayerNum列3行，每列即為各個隱藏層的輸入數目之權重(x，y，bias)
    end
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------選出輸出層權重W，並加入bias-----------------%
for i = 1:hiddenLayerNum+1
   output_w(i) = -0.5+(0.5-(-0.5))*rand(1,1);                                   %1列hiddenLayerNum+1行，每個數字即為輸出層的輸入數目之權重
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------開始訓練---------------%
time = 0;   stopCondition = 1;                                                  %設定訓練過程的次數變數、訓練的停止條件、總運行次數
while stopCondition > 0.002
    time = time + 1;
    output_wRevise_Batch = 0; hidden_wRevise_Batch = 0;
    for n=1:300
        % ---------------------將隱藏層的輸出算出--------------------------%
        for i = 1:hiddenLayerNum                                                 %5列3行，每列總和即為各個隱藏層神經數目中，sigmoid function的自變數
            hidden_vi(i,1) = hidden_w(i,1)*1;                                    %bias對隱藏層的影響(訓練集)
            hidden_vi(i,2) = hidden_w(i,2)*train_x(n);                           %x對隱藏層的影響(訓練集)
            hidden_vi(i,3) = hidden_w(i,3)*train_y(n);                           %y對隱藏層的影響(訓練集)
        end
        for i = 1:hiddenLayerNum
            hidden_v(i) = sum(hidden_vi(i,:));                                   %求得隱藏層的V。將每個神經元的V加總起來(訓練集)
        end
        for i = 1:hiddenLayerNum
            hidden_output(i) = 1/(1+exp(-hidden_v(i)));                          %求得隱藏層的輸出(訓練集)
        end
        %--------------------將輸出層的輸出算出--------------------------%
        for i = 1:hiddenLayerNum
            output_vi(i) = output_w(i)*hidden_output(i);                         %求得輸出層的Vi(訓練集)
        end
        output_v = sum(output_vi)+output_w(hiddenLayerNum+1);                    %求得輸出層的V(訓練集)，output_w(hiddenLayerNum+1)為輸出層的bias
        output_output(n) = 1/(1+exp(-output_v));                                 %求得輸出層的輸出(訓練集)
        %---------------------求得訓練集的誤差和E----------------------%
        train_e = train_z_encode(n)-output_output(n);
        E_SMode_train_temp(n) = train_e*train_e;
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%        
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%        
        %---------------------求得測試集的輸出----------------------%
        freq = mod(n,3);                                                         %由於訓練集和測試集大小不一樣，因此每當測試集取到3的倍數時，才取一次測試集的誤差值
        if freq == 0
            %---------------------將隱藏層的輸出算出--------------------------%
            for i = 1:hiddenLayerNum
                hidden_vi_test(i,1) = hidden_w(i,1)*1;                           %bias對隱藏層的影響(測試集)
                hidden_vi_test(i,2) = hidden_w(i,2)*test_x(n/3);                 %x對隱藏層的影響(測試集)
                hidden_vi_test(i,3) = hidden_w(i,3)*test_y(n/3);                 %y對隱藏層的影響(測試集)
            end
            for i = 1:hiddenLayerNum
                hidden_v_test(i) = sum(hidden_vi_test(i,:));                     %求得隱藏層的V。將每個神經元的V加總起來(測試集)
            end
            for i = 1:hiddenLayerNum
                hidden_output_test(i) = 1/(1+exp(-hidden_v_test(i)));            %求得隱藏層的輸出(測試集)
            end
            %--------------------將輸出層的輸出算出--------------------------%
            for i = 1:hiddenLayerNum
                output_vi_test(i) = output_w(i)*hidden_output_test(i);           %求得輸出層的Vi(測試集)
            end
            output_v_test = sum(output_vi_test)+output_w(hiddenLayerNum+1);      %求得輸出層的V(測試集)
            output_output_test(n/3) = 1/(1+exp(-output_v_test));                 %求得輸出層的輸出(測試集)
            %---------------------求得訓練集的誤差和E----------------------%
            test_e(n/3) = test_z_encode(n/3)-output_output_test(n/3);
            E_SMode_test_temp(n/3) = test_e(n/3) *test_e(n/3) ;
        end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%        
        %--------------------修正輸出層的W---------------------%
        for i=1:hiddenLayerNum
            etaO = train_e*output_output(n)*(1-output_output(n));
            output_wRevise(i) = learningRate* etaO *hidden_output(i);          %求得輸出層的W修正量
        end
        output_wRevise(hiddenLayerNum+1) = learningRate_bias* 1 * etaO;        %設定bias的修正量(重要!!!!!!!)
        output_wRevise_Batch = output_wRevise_Batch + output_wRevise;          %累加W修正量至W中(Batch mode)
        %--------------------修正隱藏層的W---------------------%
        for i=1:hiddenLayerNum
            etaH = etaO*output_w(i)*hidden_output(i)*(1-hidden_output(i));
            hidden_wRevise(i,1) = learningRate_bias* 1 * etaH;                 %bias的修正量(重要!!!!!!!)
            hidden_wRevise(i,2) = learningRate* etaH *train_x(n);              
            hidden_wRevise(i,3) = learningRate* etaH *train_y(n);
        end                                                                    %求得隱藏層的W修正量
        hidden_wRevise_Batch = hidden_wRevise_Batch + hidden_wRevise;          %累加W修正量至W中(Batch mode)
    end
    %--------------------momentum w revise---------------------%
    if time > 1
        output_w = output_w + output_wRevise_Batch/300 + 0.8*output_wRevise_special;
        hidden_w = hidden_w + hidden_wRevise_Batch/300 + 0.8*hidden_wRevise_special;
    elseif time == 1
        output_w = output_w + output_wRevise_Batch/300;                        %修正輸出層的W
        hidden_w = hidden_w + hidden_wRevise_Batch/300;                        %修正隱藏層的W
    end
    output_wRevise_special = output_wRevise_Batch/300;
    hidden_wRevise_special = hidden_wRevise_Batch/300;
    %-------------------not momentum w revise------------------%
%     output_w = output_w + output_wRevise_Batch/300;                            %修正輸出層的W
%     hidden_w = hidden_w + hidden_wRevise_Batch/300;                            %修正隱藏層的W
    %--------------------計算energy---------------------%
    E_SMode_train(time) = 0.5*sum(E_SMode_train_temp)/300;
    E_SMode_test(time) = 0.5*sum(E_SMode_test_temp)/100;
    %---------------更新停止變數中的數值-----------------%
    stopCondition = E_SMode_test(time);
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------將資料丟入訓練模型裡---------------%
for n = 1:100
    for i = 1:hiddenLayerNum
        hidden_vi_result(i,1) = hidden_w(i,1)*1;                           %bias對隱藏層的影響(測試集)
        hidden_vi_result(i,2) = hidden_w(i,2)*test_x(n);                   %x對隱藏層的影響(測試集)
        hidden_vi_result(i,3) = hidden_w(i,3)*test_y(n);                   %y對隱藏層的影響(測試集)
    end
    for i = 1:hiddenLayerNum
        hidden_v_result(i) = sum(hidden_vi_result(i,:));                   %求得隱藏層的V。將每個神經元的V加總起來(測試集)
    end
    for i = 1:hiddenLayerNum
        hidden_output_result(i) = 1/(1+exp(-hidden_v_result(i)));          %求得隱藏層的輸出(測試集)
    end
%--------------------將輸出層的輸出算出--------------------------%
    for i = 1:hiddenLayerNum
        output_vi_result(i) = output_w(i)*hidden_output_result(i);         %求得輸出層的Vi(測試集)
    end
    output_v_result = sum(output_vi_result)+output_w(hiddenLayerNum+1);    %求得輸出層的V(測試集)
    output_output_result(n) = 1/(1+exp(-output_v_result));                 %求得輸出層的輸出(測試集)
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------訓練模型出來的資料處理---------------%
for i = 1:100
    result(i) = (output_output_result(i)-min(output_output_result))/(max(output_output_result)-min(output_output_result))*(max(test_z)-min(test_z))+min(test_z);
end
result_plot = arrayChange(result,10,91);                          %用寫好的function將訓練模型求出的矩陣1*100轉成10*10
test_z_plot = arrayChange(test_z,10,91);                          %用寫好的function將測試集矩陣1*100轉成10*10
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------繪圖---------------%
subplot(2,2,1); surf(z);  shading interp                          %根據題目給的非線性方程式，繪出圖形
title('Standard Graphics'); 
xlabel('X'); ylabel('Y'); zlabel('Z');

subplot(2,2,4); surf(result_plot);  shading interp                %根據訓練結果，繪出圖形
title({['Training Result (Batch Mode、Gradient Descent With Momentum)'],['Hidden Layer = ',mat2str(hiddenLayerNum),'   Learning Rate = ',mat2str(learningRate),'   Epoch = ' mat2str(time)]}); 
xlabel('X'); ylabel('Y'); zlabel('Z');

subplot(2,2,3); surf(test_z_plot);  shading interp                %根據測試集的數據，繪出圖形
title('Test Data Graphics'); 
xlabel('X'); ylabel('Y'); zlabel('Z');

figure(2);
plot_x = 0:1:time-1;
plot(plot_x,E_SMode_train); hold on; 
plot(plot_x,E_SMode_test);                                        %繪出圖形訓練集與測試集之誤差隨Cycle的趨勢圖
title({['Energy Run Chart (Batch Mode、Gradient Descent With Momentum)'],[ 'Hidden Layer = ',mat2str(hiddenLayerNum),'   Learning Rate = ',mat2str(learningRate),'   Epoch = ',mat2str(time)]});
xlabel('Number of Epoch'); ylabel('Energy'); legend('TRAIN','TEST');
