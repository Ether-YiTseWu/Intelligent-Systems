clc; clear;
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---------�]�w�ϧΪ�x,y,z------------%
interval = 1.5/21;                               
x = -0.8+interval : interval :0.7-interval;             %�]�wx�b�ƭ�
y = -0.8+interval : interval :0.7-interval;             %�]�wy�b�ƭ�
for i=1:20                                              %�]�wz�b�ƭ�
    for j=1:20
        z(i,j) = 5*sin(pi*x(i)^2)*sin(2*pi*y(j))+1;
    end
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---------�o��V�m��----------%
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
end                                                 %���ǳƥH�����Asource���C��x�My�涰�X�Ӫ����G
index_train = sort(randperm(400,300));              %�]�w�ü�INDEX(���ն�)
train_x = getTrainAndTest(source,index_train,300,1);
train_y = getTrainAndTest(source,index_train,300,2);
for i=1:300
    train_z(i) = 5*sin(pi*train_x(i)^2)*sin(2*pi*train_y(i))+1;
end                                                                                    %�����V�m��
train_z_encode = (train_z-min(train_z))/(max(train_z)-min(train_z))*(0.8-0.2)+0.2;     %�N����ȥ��W�Ʀ�0.2~0.8���ƭ�(�V�m��)
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---------�o����ն�----------%
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
end                                        %�]�w�ü�INDEX(�V�m��)
test_x = getTrainAndTest(source,index_test,100,1);
test_y = getTrainAndTest(source,index_test,100,2);
for i=1:100
    test_z(i) = 5*sin(pi*test_x(i)^2)*sin(2*pi*test_y(i))+1;
end                                                                                    %�������ն�
test_z_encode = (test_z-min(test_z))/(max(test_z)-min(test_z))*(0.8-0.2)+0.2;          %�N����ȥ��W�Ʀ�0.2~0.8���ƭ�(���ն�)
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------�]�w���üh�ƥؤξǲ߳t��-----------------%
hiddenLayerNum = 10;   learningRate = 5;     learningRate_bias = learningRate;
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------��X���üh�v��W�A�å[�Jbias-----------------%
for i = 1:hiddenLayerNum
    for j = 1:3
        hidden_w(i,j) = -0.5+(0.5-(-0.5))*rand(1,1);                            %5�C3��A�C�C�Y���U�����üh���g�ƥت���J�v��
    end
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------��X��X�h�v��W�A�å[�Jbias-----------------%
for i = 1:hiddenLayerNum+1
   output_w(i) = -0.5+(0.5-(-0.5))*rand(1,1);                                   %1�C5��A�C��Y���U�ӿ�X�h���g�ƥت���J�v��
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------�}�l�V�m---------------%
time = 0;   stopCondition = 1;                                                  %�]�w�V�m�L�{�������ܼơB�V�m���������B�`�B�榸��
while stopCondition > 0.002
    time = time + 1;
    output_wRevise_Batch = 0; hidden_wRevise_Batch = 0;
    for n=1:300
        % ---------------------�N���üh����X��X--------------------------%
        for i = 1:hiddenLayerNum                                                 %5�C3��A�C�C�`�M�Y���U�����üh���g�ƥؤ��Asigmoid function�����ܼ�
            hidden_vi(i,1) = hidden_w(i,1)*1;                                    %bias�����üh���v�T(�V�m��)
            hidden_vi(i,2) = hidden_w(i,2)*train_x(n);                           %x�����üh���v�T(�V�m��)
            hidden_vi(i,3) = hidden_w(i,3)*train_y(n);                           %y�����üh���v�T(�V�m��)
        end
        for i = 1:hiddenLayerNum
            hidden_v(i) = sum(hidden_vi(i,:));                                   %�D�o���üh��V�C�N�C�ӯ��g����V�[�`�_��(�V�m��)
        end
        for i = 1:hiddenLayerNum
            hidden_output(i) = 1/(1+exp(-hidden_v(i)));                          %�D�o���üh����X(�V�m��)
        end
        %--------------------�N��X�h����X��X--------------------------%
        for i = 1:hiddenLayerNum
            output_vi(i) = output_w(i)*hidden_output(i);                         %�D�o��X�h��Vi(�V�m��)
        end
        output_v = sum(output_vi)+output_w(hiddenLayerNum+1);                    %�D�o��X�h��V(�V�m��)
        output_output(n) = 1/(1+exp(-output_v));                                 %�D�o��X�h����X(�V�m��)
        %---------------------�D�o�V�m�����~�t�ME----------------------%
        train_e = train_z_encode(n)-output_output(n);
        E_SMode_train_temp(n) = train_e*train_e;
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%        
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%        
        %---------------------�D�o���ն�����X----------------------%
        freq = mod(n,3);                                                         %�ѩ�V�m���M���ն��j�p���@�ˡA�]���C����ն�����3�����ƮɡA�~���@�����ն����~�t��
        if freq == 0
            %---------------------�N���üh����X��X--------------------------%
            for i = 1:hiddenLayerNum
                hidden_vi_test(i,1) = hidden_w(i,1)*1;                           %bias�����üh���v�T(���ն�)
                hidden_vi_test(i,2) = hidden_w(i,2)*test_x(n/3);                 %x�����üh���v�T(���ն�)
                hidden_vi_test(i,3) = hidden_w(i,3)*test_y(n/3);                 %y�����üh���v�T(���ն�)
            end
            for i = 1:hiddenLayerNum
                hidden_v_test(i) = sum(hidden_vi_test(i,:));                     %�D�o���üh��V�C�N�C�ӯ��g����V�[�`�_��(���ն�)
            end
            for i = 1:hiddenLayerNum
                hidden_output_test(i) = 1/(1+exp(-hidden_v_test(i)));            %�D�o���üh����X(���ն�)
            end
            %--------------------�N��X�h����X��X--------------------------%
            for i = 1:hiddenLayerNum
                output_vi_test(i) = output_w(i)*hidden_output_test(i);           %�D�o��X�h��Vi(���ն�)
            end
            output_v_test = sum(output_vi_test)+output_w(hiddenLayerNum+1);      %�D�o��X�h��V(���ն�)
            output_output_test(n/3) = 1/(1+exp(-output_v_test));                 %�D�o��X�h����X(���ն�)
            %---------------------�D�o�V�m�����~�t�ME----------------------%
            test_e(n/3) = test_z_encode(n/3)-output_output_test(n/3);
            E_SMode_test_temp(n/3) = test_e(n/3) *test_e(n/3) ;
        end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%        
        %--------------------�ץ���X�h��W---------------------%
        for i=1:hiddenLayerNum
            etaO = train_e*output_output(n)*(1-output_output(n));
            output_wRevise(i) = learningRate* etaO *hidden_output(i);          %�D�o��X�h��W�ץ��q
        end
        output_wRevise(hiddenLayerNum+1) = learningRate_bias* 1 * etaO;        %�]�wbias���ץ��q(���n!!!!!!!)
        output_wRevise_Batch = output_wRevise_Batch + output_wRevise;          %�֥[W�ץ��q��W��(Batch mode)
        %--------------------�ץ����üh��W---------------------%
        for i=1:hiddenLayerNum
            etaH = etaO*output_w(i)*hidden_output(i)*(1-hidden_output(i));
            hidden_wRevise(i,1) = learningRate_bias* 1 * etaH;                 %bias���ץ��q(���n!!!!!!!)
            hidden_wRevise(i,2) = learningRate* etaH *train_x(n);              
            hidden_wRevise(i,3) = learningRate* etaH *train_y(n);
        end                                                                    %�D�o���üh��W�ץ��q
        hidden_wRevise_Batch = hidden_wRevise_Batch + hidden_wRevise;          %�֥[W�ץ��q��W��(Batch mode)
    end
    %--------------------momentum w revise---------------------%
    if time > 1
        output_w = output_w + output_wRevise_Batch/300 + 0.8*output_wRevise_special;
        hidden_w = hidden_w + hidden_wRevise_Batch/300 + 0.8*hidden_wRevise_special;
    elseif time == 1
        output_w = output_w + output_wRevise_Batch/300;                        %�ץ���X�h��W
        hidden_w = hidden_w + hidden_wRevise_Batch/300;                        %�ץ����üh��W
    end
    output_wRevise_special = output_wRevise_Batch/300;
    hidden_wRevise_special = hidden_wRevise_Batch/300;
    %-------------------not momentum w revise------------------%
%     output_w = output_w + output_wRevise_Batch/300;                            %�ץ���X�h��W
%     hidden_w = hidden_w + hidden_wRevise_Batch/300;                            %�ץ����üh��W
    %--------------------�p��energy---------------------%
    E_SMode_train(time) = 0.5*sum(E_SMode_train_temp)/300;
    E_SMode_test(time) = 0.5*sum(E_SMode_test_temp)/100;
    %---------------��s�����ܼƤ����ƭ�-----------------%
    stopCondition = E_SMode_test(time);
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------�N��ƥ�J�V�m�ҫ���---------------%
for n = 1:100
    for i = 1:hiddenLayerNum
        hidden_vi_result(i,1) = hidden_w(i,1)*1;                           %bias�����üh���v�T(���ն�)
        hidden_vi_result(i,2) = hidden_w(i,2)*test_x(n);                   %x�����üh���v�T(���ն�)
        hidden_vi_result(i,3) = hidden_w(i,3)*test_y(n);                   %y�����üh���v�T(���ն�)
    end
    for i = 1:hiddenLayerNum
        hidden_v_result(i) = sum(hidden_vi_result(i,:));                   %�D�o���üh��V�C�N�C�ӯ��g����V�[�`�_��(���ն�)
    end
    for i = 1:hiddenLayerNum
        hidden_output_result(i) = 1/(1+exp(-hidden_v_result(i)));          %�D�o���üh����X(���ն�)
    end
%--------------------�N��X�h����X��X--------------------------%
    for i = 1:hiddenLayerNum
        output_vi_result(i) = output_w(i)*hidden_output_result(i);         %�D�o��X�h��Vi(���ն�)
    end
    output_v_result = sum(output_vi_result)+output_w(hiddenLayerNum+1);    %�D�o��X�h��V(���ն�)
    output_output_result(n) = 1/(1+exp(-output_v_result));                 %�D�o��X�h����X(���ն�)
end
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------�V�m�ҫ��X�Ӫ���ƳB�z---------------%
for i = 1:100
    result(i) = (output_output_result(i)-min(output_output_result))/(max(output_output_result)-min(output_output_result))*(max(test_z)-min(test_z))+min(test_z);
end
result_plot = arrayChange(result,10,91);                          %�μg�n��function�N�V�m�ҫ��D�X���x�}1*100�ন10*10
test_z_plot = arrayChange(test_z,10,91);                          %�μg�n��function�N���ն��x�}1*100�ন10*10
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
% --------------ø��---------------%
subplot(2,2,1); surf(z);  shading interp                          %�ھ��D�ص����D�u�ʤ�{���Aø�X�ϧ�
title('Standard Graphics'); 
xlabel('X'); ylabel('Y'); zlabel('Z');

subplot(2,2,4); surf(result_plot);  shading interp                %�ھڰV�m���G�Aø�X�ϧ�
title({['Training Result (Batch Mode�BGradient Descent With Momentum)'],['Hidden Layer = ',mat2str(hiddenLayerNum),'   Learning Rate = ',mat2str(learningRate),'   Epoch = ' mat2str(time)]}); 
xlabel('X'); ylabel('Y'); zlabel('Z');

subplot(2,2,3); surf(test_z_plot);  shading interp                %�ھڴ��ն����ƾڡAø�X�ϧ�
title('Test Data Graphics'); 
xlabel('X'); ylabel('Y'); zlabel('Z');

figure(2);
plot_x = 0:1:time-1;
plot(plot_x,E_SMode_train); hold on; 
plot(plot_x,E_SMode_test);                                        %ø�X�ϧΰV�m���P���ն����~�t�HCycle���Ͷչ�
title({['Energy Run Chart (Batch Mode�BGradient Descent With Momentum)'],[ 'Hidden Layer = ',mat2str(hiddenLayerNum),'   Learning Rate = ',mat2str(learningRate),'   Epoch = ',mat2str(time)]});
xlabel('Number of Epoch'); ylabel('Energy'); legend('TRAIN','TEST');