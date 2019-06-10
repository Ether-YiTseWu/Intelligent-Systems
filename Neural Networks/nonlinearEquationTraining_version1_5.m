clc; clear;

interval = 1.5/401;                               

x = -0.8+interval : interval :0.7-interval;             %設定x軸數值
y = -0.8+interval : interval :0.7-interval;             %設定y軸數值
for i=1:400                                             %設定z軸數值
    for j=1:400
        z(i,j) = 5*sin(pi*x(i)^2)*sin(2*pi*y(j))+1;
    end
end
% [X,Y]=meshgrid(x,y);  surf(X,Y,z);  shading interp      %根據題目敘述繪出圖形


%---------得到訓練集與測試集------------%
index = randperm(400,400);                                %設定亂數INDEX

for i=1:300
    train_x(i) = x(index(i));
end
for i=1:300
    train_y(i) = y(index(i));
end
for i=1:300
    train_z(i) = 5*sin(pi*train_x(i)^2)*sin(2*pi*train_y(i))+1;
end                                                                             %切分訓練集
train_z_encode = (train_z-min(train_z))/(max(train_z)-min(train_z))*(0.8-0.2)+0.2;     %將期望值正規化至0.2~0.8的數值(訓練集)

for i=1:100
    test_x(i) = x(index(i+300));
end
for i=1:100
    test_y(i) = y(index(i+300));
end
for i=1:100
    test_z(i) = 5*sin(pi*test_x(i)^2)*sin(2*pi*test_y(i))+1;
end                                                                             %切分測試集
test_z_encode = (test_z-min(test_z))/(max(test_z)-min(test_z))*(0.8-0.2)+0.2;          %將期望值正規化至0.2~0.8的數值(測試集)

%--------------五個隱藏層。隨機從-0.5~0.5間，選出隱藏層及輸出層的權重W-----------------%
for i = 1:5
    for j = 1:3
        hidden_w(i,j) = -0.5+(0.5-(-0.5))*rand(1,1);                            %5列3行，每列即為各個隱藏層神經數目的輸入權重
    end
end

for i = 1:5
   output_w(i) = -0.5+(0.5-(-0.5))*rand(1,1);                                   %1列5行，每行即為各個輸出層神經數目的輸入權重
end

%--------------計算五個隱藏層。Sequential mode---------------%
time = 1; learningRate = 0.001;
for time=1:300
    for n=1:300
        %---------------------將隱藏層的輸出算出--------------------------%
        for i = 1:5                                                              %5列3行，每列總和即為各個隱藏層神經數目sigmoid function自變數
            hidden_vi(i,2) = hidden_w(i,2)*train_x(n);                           %x對隱藏層的影響(訓練集)
            hidden_vi(i,3) = hidden_w(i,3)*train_y(n);                           %y對隱藏層的影響(訓練集)
        end
        hidden_vi(:,1) = hidden_w(:,1);                                          %求得隱藏層的Vi(訓練集)
        %hidden_v中的第一行為bias，bias設的權重為1，因此直接加入到hidden_v中即可

        for i = 1:5
            hidden_v(i) = sum(hidden_vi(i,:));                                   %求得隱藏層的V。將每個神經元的V加總起來(訓練集)
        end

        for i = 1:5
            hidden_output(i) = 1/(1+exp(-hidden_v(i)));                          %求得隱藏層的輸出(訓練集)
            %將V代入sigmoid function，找到Artivation function的響應值
        end
        
        %--------------------將輸出層的輸出算出--------------------------%
        for i = 1:5
            output_vi(i) = output_w(i)*hidden_output(i);                         %求得輸出層的Vi(訓練集)
        end
        output_v = sum(output_vi);                                               %求得輸出層的V(訓練集)
        output_output(n) = 1/(1+exp(-output_v));                                 %求得輸出層的輸出(訓練集)
        
       %---------------------求得誤差----------------------%
        train_e(n) = train_z_encode(n)-output_output(n);                         %求得誤差e(訓練集)
        
        freq = mod(n,3);                                                         %由於訓練集和測試集大小不一樣，因此每當測試集取到3的倍數時，才取一次測試集的誤差值
        if freq == 0
            %---------------------將隱藏層的輸出算出--------------------------%
            for i = 1:5
                hidden_vi_test(i,2) = hidden_w(i,2)*test_x(n/3);                 %x對隱藏層的影響(測試集)
                hidden_vi_test(i,3) = hidden_w(i,3)*test_y(n/3);                 %y對隱藏層的影響(測試集)
            end
            hidden_vi_test(:,1) = hidden_w(:,1);                                 %求得隱藏層的Vi(測試集)
            for i = 1:5
                hidden_v_test(i) = sum(hidden_vi_test(i,:));                     %求得隱藏層的V。將每個神經元的V加總起來(測試集)
            end
            for i = 1:5
                hidden_output_test(i) = 1/(1+exp(-hidden_v_test(i)));            %求得隱藏層的輸出(測試集)
            end
            %--------------------將輸出層的輸出算出--------------------------%
            for i = 1:5
                output_vi_test(i) = output_w(i)*hidden_output_test(i);           %求得輸出層的Vi(測試集)
            end
            output_v_test = sum(output_vi_test);                                 %求得輸出層的V(測試集)
            output_output_test(n/3) = 1/(1+exp(-output_v_test));                 %求得輸出層的輸出(測試集)
            
            test_e(n/3) = train_z(n/3)-output_output_test(n/3);                  %求得誤差e(訓練集)
        end
        
        %--------------------修正W---------------------%
        output_wRevise = learningRate* (train_e(n)*output_output(n)*(1-output_output(n))) *output_output(n);  %求得輸出層的W修正量
        output_w = output_w + output_wRevise;                                                                 %套用W修正量至W中
        for i=1:5
            hidden_wRevise(i) = learningRate* (( output_wRevise*sum(hidden_w(1,:)) )*hidden_output(i)*(1-hidden_output(i))) *hidden_output(i);
        end                                                                      %求得隱藏層的W修正量
        for i=1:5
            hidden_w(i,:) = hidden_w(i,:) + hidden_wRevise(i);                   %套用W修正量至W中
        end
    end
    
    E_SMode_train(time) = 0.5*(sum(train_e)/300)*(sum(train_e)/300);
    E_SMode_test(time) = 0.5*(sum(test_e)/100)*(sum(test_e)/100);
end

test_e_decode(n/3) = test_e(n/3)+test_e_output;
test_e_decode(n/3) = (test_e_decode(n/3)-0.2)*(max(test_z)-min(test_z))/0.6+0.2;


plot_x = 0:1:time-1;
plot(plot_x,E_SMode_train); hold on; plot(plot_x,E_SMode_test);
title('5 hidden layer、Sequential mode、learning rate = 0.001'); xlabel('number of cycles'); ylabel('energy'); legend('train','test')