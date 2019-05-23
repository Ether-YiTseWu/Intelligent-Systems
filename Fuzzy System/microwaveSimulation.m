clear;
clc;

x=-4:0.1:4; y=0:0.1:2; [X,Y]=meshgrid(x,y);     %�]�wX�BY�b

xx = -4:0.1:0; yy = -xx/4;  leng = length(yy);
tempLow_AlphaCut = [yy zeros(1,81-leng)];       %�C�� ���ҽk���X���ܼơC(�]���D��J�����I��J�A�G���ܼƵ���AlphaCut)

xx = 1:0.1:2; yy = -1+xx;
weightHeavy_AlphaCut = [zeros(1,10) yy];        %�� ���ҽk���X���ܼơC

xx = 1000:1200; yy = (-1000+xx)/200;            %���\�v ���ҽk���X���ܼơC
powerHigh = [zeros(1,1000) yy];

for i=1:21
     for j=1:81
         Rule1_AlphaCut(i,j)=min(weightHeavy_AlphaCut(i),tempLow_AlphaCut(j));  %�����W�h�@�A�Nx�My���C�ӿ�J�ұo�쪺AlphaCut�����p�B��A�@�o��21*81�����
     end
end

for i=1:21
     for j=1:81
         for k=1:1201
             temp = Rule1_AlphaCut(i,j);
             Rule1_powerOutput(i*j,k) = min (temp,powerHigh(k));    %Rule1_powerOutput���C�@�C�N���\�v��ƻPRule1_AlphaCut�����p�B�⵲�G�A����N���������ƫK�i�o��
         end
     end
end

for i=1:1701
    for j=1:1201
        numerator = 0;                                              %21~38�榳���A3/30�A�ӧ�a�C �ĤG�Q����֩w�����D�C������Rule1_powerOutput���ȥ������O�s�C
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