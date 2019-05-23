clear;
clc;
%------------------------------------------------------------------------------------------------------------------------------------------------------%
x=-4:0.1:4; y=0:0.1:2; [X,Y]=meshgrid(x,y);     %�]�wX�BY�b
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = -4:0.1:0; yy = -xx/4;  leng = length(yy);
tempLow_AlphaCut = [yy zeros(1,81-leng)];       %�C�� ���ҽk���X���ܼơC(�]���D��J�����I��J�A�G���ܼƵ���AlphaCut)

xx1 = -3  :0.1:0; yy1 = (3+xx1)/3;  
xx2 =  0.1:0.1:3; yy2 = (3-xx2)/3;
zero = zeros(1,10);
tempMedium_AlphaCut = [zero yy1 yy2 zero];      %������ ���ҽk���X���ܼơC

xx = 0:0.1:4; yy = xx/4;  leng = length(yy);
tempHigh_AlphaCut = [yy zeros(1,81-leng)];      %���� ���ҽk���X���ܼơC(�]���D��J�����I��J�A�G���ܼƵ���AlphaCut)
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 1:0.1:2; yy = -1+xx;
weightHeavy_AlphaCut = [zeros(1,10) yy];        %�� ���ҽk���X���ܼơC

xx1 =  0  :0.1:1; yy1 = xx1;  
xx2 =  1.1:0.1:2; yy2 = 2-xx2;
weightMedium_AlphaCut = [yy1 yy2];              %������ ���ҽk���X���ܼơC

xx = 0:0.1:1; yy =  1-xx;
weightLight_AlphaCut = [yy zeros(1,10)];        %�� ���ҽk���X���ܼơC
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 1000:1200; yy = (-1000+xx)/200;            
powerHigh = [zeros(1,1000) yy];                 %���\�v ���ҽk���X���ܼơC

xx1 =  700:900;  yy1 = -700+xx1;  
xx2 =  901:1100; yy2 = 1100-xx2; 
zero = zeros(1,400);
powerMedium = [zero yy1 yy2 zero];              %�����\�v ���ҽk���X���ܼơC

xx = 600:800; yy = (800-xx)/200;            
powerLow = [yy zeros(1,1000)];                  %�C�\�v ���ҽk���X���ܼơC
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 5:10; yy = -5+xx;            
op_timeLong = [zeros(1,5) yy];                  %���B��ɶ� ���ҽk���X���ܼơC

xx1 =  0:5 ; yy1 = xx1/5;  
xx2 =  6:10; yy2 = (10-xx2)/5;            
op_timeMedium = [yy1 yy2];                      %�����B��ɶ� ���ҽk���X���ܼơC

xx = 0:5; yy = (5-xx)/5;            
op_timeShort = [yy zeros(1,5)];                 %�u�B��ɶ� ���ҽk���X���ܼơC
%------------------------------------------------------------------------------------------------------------------------------------------------------%
for i=1:21
     for j=1:81
         temp1 = weightHeavy_AlphaCut(i);
         temp2 = tempLow_AlphaCut(j);
         Rule1_AlphaCut(i,j)=min(temp1,temp2);  %�����W�h�@�A�Nx�My���C�ӿ�J�ұo�쪺AlphaCut�����p�B��A�@�o��21*81�����
     end
end

for i=1:21                                                   %�N�C��AlphaCut��ƻP��X�ϧΰ����p�B��A�H�o��Rule1_powerOutput
     for j=1:81
             numerator = 0;                                              
             denominator = 0;
         for k=600:1200                                      %�\�v����ƥi�঳���A�e�X�Ӫ��ϳ��M��0~600W????������X�̨S���o����
             temp1 = Rule1_AlphaCut(i,j);
             temp2 = powerHigh(k+1);
         
             numerator = numerator + k*min (temp1,temp2);    %min (temp1,temp2)���C�@�C�N���\�v��ƻPRule1_AlphaCut�����p�B�⵲�G�A����N���������ƫK�i�o��
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
surf(X,Y,Rule1_powerAns);     title("Microwave Oven Simalation (Fuzzy Theory)"); xlabel('Temperature(�XC)'); ylabel('Weight(kg)'); zlabel('Power(w)');

%subplot(1,2,2); 
%surf(X,Y,Rule1_op_timeAns);   title("Microwave Oven Simalation (Fuzzy Theory)"); xlabel('Temperature(�XC)'); ylabel('Weight(kg)'); zlabel('Operation Time(min)');