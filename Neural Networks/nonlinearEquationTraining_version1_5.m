clc; clear;

interval = 1.5/401;                               

x = -0.8+interval : interval :0.7-interval;             %�]�wx�b�ƭ�
y = -0.8+interval : interval :0.7-interval;             %�]�wy�b�ƭ�
for i=1:400                                             %�]�wz�b�ƭ�
    for j=1:400
        z(i,j) = 5*sin(pi*x(i)^2)*sin(2*pi*y(j))+1;
    end
end
% [X,Y]=meshgrid(x,y);  surf(X,Y,z);  shading interp      %�ھ��D�رԭzø�X�ϧ�


%---------�o��V�m���P���ն�------------%
index = randperm(400,400);                                %�]�w�ü�INDEX

for i=1:300
    train_x(i) = x(index(i));
end
for i=1:300
    train_y(i) = y(index(i));
end
for i=1:300
    train_z(i) = 5*sin(pi*train_x(i)^2)*sin(2*pi*train_y(i))+1;
end                                                                             %�����V�m��
train_z_encode = (train_z-min(train_z))/(max(train_z)-min(train_z))*(0.8-0.2)+0.2;     %�N����ȥ��W�Ʀ�0.2~0.8���ƭ�(�V�m��)

for i=1:100
    test_x(i) = x(index(i+300));
end
for i=1:100
    test_y(i) = y(index(i+300));
end
for i=1:100
    test_z(i) = 5*sin(pi*test_x(i)^2)*sin(2*pi*test_y(i))+1;
end                                                                             %�������ն�
test_z_encode = (test_z-min(test_z))/(max(test_z)-min(test_z))*(0.8-0.2)+0.2;          %�N����ȥ��W�Ʀ�0.2~0.8���ƭ�(���ն�)

%--------------�������üh�C�H���q-0.5~0.5���A��X���üh�ο�X�h���v��W-----------------%
for i = 1:5
    for j = 1:3
        hidden_w(i,j) = -0.5+(0.5-(-0.5))*rand(1,1);                            %5�C3��A�C�C�Y���U�����üh���g�ƥت���J�v��
    end
end

for i = 1:5
   output_w(i) = -0.5+(0.5-(-0.5))*rand(1,1);                                   %1�C5��A�C��Y���U�ӿ�X�h���g�ƥت���J�v��
end

%--------------�p�⤭�����üh�CSequential mode---------------%
time = 1; learningRate = 0.001;
for time=1:300
    for n=1:300
        %---------------------�N���üh����X��X--------------------------%
        for i = 1:5                                                              %5�C3��A�C�C�`�M�Y���U�����üh���g�ƥ�sigmoid function���ܼ�
            hidden_vi(i,2) = hidden_w(i,2)*train_x(n);                           %x�����üh���v�T(�V�m��)
            hidden_vi(i,3) = hidden_w(i,3)*train_y(n);                           %y�����üh���v�T(�V�m��)
        end
        hidden_vi(:,1) = hidden_w(:,1);                                          %�D�o���üh��Vi(�V�m��)
        %hidden_v�����Ĥ@�欰bias�Abias�]���v����1�A�]�������[�J��hidden_v���Y�i

        for i = 1:5
            hidden_v(i) = sum(hidden_vi(i,:));                                   %�D�o���üh��V�C�N�C�ӯ��g����V�[�`�_��(�V�m��)
        end

        for i = 1:5
            hidden_output(i) = 1/(1+exp(-hidden_v(i)));                          %�D�o���üh����X(�V�m��)
            %�NV�N�Jsigmoid function�A���Artivation function���T����
        end
        
        %--------------------�N��X�h����X��X--------------------------%
        for i = 1:5
            output_vi(i) = output_w(i)*hidden_output(i);                         %�D�o��X�h��Vi(�V�m��)
        end
        output_v = sum(output_vi);                                               %�D�o��X�h��V(�V�m��)
        output_output(n) = 1/(1+exp(-output_v));                                 %�D�o��X�h����X(�V�m��)
        
       %---------------------�D�o�~�t----------------------%
        train_e(n) = train_z_encode(n)-output_output(n);                         %�D�o�~�te(�V�m��)
        
        freq = mod(n,3);                                                         %�ѩ�V�m���M���ն��j�p���@�ˡA�]���C����ն�����3�����ƮɡA�~���@�����ն����~�t��
        if freq == 0
            %---------------------�N���üh����X��X--------------------------%
            for i = 1:5
                hidden_vi_test(i,2) = hidden_w(i,2)*test_x(n/3);                 %x�����üh���v�T(���ն�)
                hidden_vi_test(i,3) = hidden_w(i,3)*test_y(n/3);                 %y�����üh���v�T(���ն�)
            end
            hidden_vi_test(:,1) = hidden_w(:,1);                                 %�D�o���üh��Vi(���ն�)
            for i = 1:5
                hidden_v_test(i) = sum(hidden_vi_test(i,:));                     %�D�o���üh��V�C�N�C�ӯ��g����V�[�`�_��(���ն�)
            end
            for i = 1:5
                hidden_output_test(i) = 1/(1+exp(-hidden_v_test(i)));            %�D�o���üh����X(���ն�)
            end
            %--------------------�N��X�h����X��X--------------------------%
            for i = 1:5
                output_vi_test(i) = output_w(i)*hidden_output_test(i);           %�D�o��X�h��Vi(���ն�)
            end
            output_v_test = sum(output_vi_test);                                 %�D�o��X�h��V(���ն�)
            output_output_test(n/3) = 1/(1+exp(-output_v_test));                 %�D�o��X�h����X(���ն�)
            
            test_e(n/3) = train_z(n/3)-output_output_test(n/3);                  %�D�o�~�te(�V�m��)
        end
        
        %--------------------�ץ�W---------------------%
        output_wRevise = learningRate* (train_e(n)*output_output(n)*(1-output_output(n))) *output_output(n);  %�D�o��X�h��W�ץ��q
        output_w = output_w + output_wRevise;                                                                 %�M��W�ץ��q��W��
        for i=1:5
            hidden_wRevise(i) = learningRate* (( output_wRevise*sum(hidden_w(1,:)) )*hidden_output(i)*(1-hidden_output(i))) *hidden_output(i);
        end                                                                      %�D�o���üh��W�ץ��q
        for i=1:5
            hidden_w(i,:) = hidden_w(i,:) + hidden_wRevise(i);                   %�M��W�ץ��q��W��
        end
    end
    
    E_SMode_train(time) = 0.5*(sum(train_e)/300)*(sum(train_e)/300);
    E_SMode_test(time) = 0.5*(sum(test_e)/100)*(sum(test_e)/100);
end

test_e_decode(n/3) = test_e(n/3)+test_e_output;
test_e_decode(n/3) = (test_e_decode(n/3)-0.2)*(max(test_z)-min(test_z))/0.6+0.2;


plot_x = 0:1:time-1;
plot(plot_x,E_SMode_train); hold on; plot(plot_x,E_SMode_test);
title('5 hidden layer�BSequential mode�Blearning rate = 0.001'); xlabel('number of cycles'); ylabel('energy'); legend('train','test')