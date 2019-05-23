clear;
clc;                                            %��l��
x=-4:0.1:4; y=0:0.1:2; [X,Y]=meshgrid(x,y);     %�]�wX�BY�b
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = -4:0.1:0; yy = -xx/4;  leng = length(yy);
tempLow_AlphaCut = [yy zeros(1,81-leng)];       %�C�� ���ҽk���X���ܼơC(�]���D��J�����I��J�A�G���ܼƵ���AlphaCut)

xx1 = -3  :0.1:0; yy1 = (3+xx1)/3;  
xx2 =  0.1:0.1:3; yy2 = (3-xx2)/3;
zero = zeros(1,10);
tempMedium_AlphaCut = [zero yy1 yy2 zero];      %������ ���ҽk���X���ܼơC

xx = 0:0.1:4; yy = xx/4;  leng = length(yy);
tempHigh_AlphaCut = [zeros(1,81-leng) yy];      %���� ���ҽk���X���ܼơC(�]���D��J�����I��J�A�G���ܼƵ���AlphaCut)

% plot(x,tempLow_AlphaCut,'b');
% hold on;
% plot(x,tempMedium_AlphaCut,'g');              %ø�s�D�ةҵ����ū׹ϧ�
% hold on;
% plot(x,tempHigh_AlphaCut,'red');
% hold on;
% legend('Low temp','Medium temp','High temp');  xlabel('X:Temperature(�XC)');   ylabel('Y:Degree of Membership');
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 1:0.1:2; yy = -1+xx;
weightHeavy_AlphaCut = [zeros(1,10) yy];        %�� ���ҽk���X���ܼơC

xx1 =  0  :0.1:1; yy1 = xx1;  
xx2 =  1.1:0.1:2; yy2 = 2-xx2;
weightMedium_AlphaCut = [yy1 yy2];              %������ ���ҽk���X���ܼơC

xx = 0:0.1:1; yy =  1-xx;
weightLight_AlphaCut = [yy zeros(1,10)];        %�� ���ҽk���X���ܼơC

% plot(y,weightLight_AlphaCut,'b');
% hold on;
% plot(y,weightMedium_AlphaCut,'g');            %ø�s�D�ةҵ������q�ϧ�
% hold on;
% plot(y,weightHeavy_AlphaCut,'red');
% hold on;
% legend('Light weight','Medium weight','Heavy weight');  xlabel('X:Weight(Kg)');   ylabel('Y:Degree of Membership');
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 1000:1200; yy = (-1000+xx)/200;            
powerHigh = [zeros(1,400) yy];                 %���\�v ���ҽk���X���ܼơC

xx1 =  700:900;  yy1 = (-700+xx1)/200;  
xx2 =  901:1100; yy2 = (1100-xx2)/200; 
zero = zeros(1,100);
powerMedium = [zero yy1 yy2 zero];             %�����\�v ���ҽk���X���ܼơC

xx = 600:800; yy = (800-xx)/200;    
powerLow = [yy zeros(1,400)];                  %�C�\�v ���ҽk���X���ܼơC

% tempX = 600:1200; 
% plot(tempX,powerLow,'b');
% hold on;
% plot(tempX,powerMedium,'g');                 %ø�s�D�ةҵ����\�v�ϧ�
% hold on;
% plot(tempX,powerHigh,'red');
% hold on;
% legend('Low power','Medium power','High power');  xlabel('X:Power(w)');   ylabel('Y:Degree of Membership');
%------------------------------------------------------------------------------------------------------------------------------------------------------%
xx = 5:10; yy = (-5+xx)/5;            
op_timeLong = [zeros(1,5) yy];                  %���B��ɶ� ���ҽk���X���ܼơC

xx1= 0:5 ; yy1 = xx1/5;  
xx2= 6:10; yy2 = (10-xx2)/5;            
op_timeMedium = [yy1 yy2];                      %�����B��ɶ� ���ҽk���X���ܼơC

xx = 0:5; yy = (5-xx)/5;            
op_timeShort = [yy zeros(1,5)];                 %�u�B��ɶ� ���ҽk���X���ܼơC

% tempX = 0:10; 
% plot(tempX,op_timeLong,'red');
% hold on;
% plot(tempX,op_timeMedium,'g');                  %ø�s�D�ةҵ����B��ɶ��ϧ�
% hold on;
% plot(tempX,op_timeShort,'b');
% hold on;
% legend('Long operation time','Medium operation time','Short operation time');  xlabel('X:Time(min)');   ylabel('Y:Degree of Membership');
%------------------------------------------------------------------------------------------------------------------------------------------------------%
Rule1_AlphaCut   =  RealAlphaCut(weightHeavy_AlphaCut ,tempLow_AlphaCut);
Rule2_AlphaCut   =  RealAlphaCut(weightMedium_AlphaCut,tempLow_AlphaCut);
Rule3_AlphaCut   =  RealAlphaCut(weightLight_AlphaCut ,tempLow_AlphaCut);
Rule4_AlphaCut   =  RealAlphaCut(weightHeavy_AlphaCut ,tempMedium_AlphaCut);
Rule5_AlphaCut   =  RealAlphaCut(weightMedium_AlphaCut,tempMedium_AlphaCut);       
Rule6_AlphaCut   =  RealAlphaCut(weightLight_AlphaCut ,tempMedium_AlphaCut);
Rule7_AlphaCut   =  RealAlphaCut(weightHeavy_AlphaCut ,tempHigh_AlphaCut);
Rule8_AlphaCut   =  RealAlphaCut(weightMedium_AlphaCut,tempHigh_AlphaCut);
Rule9_AlphaCut   =  RealAlphaCut(weightLight_AlphaCut ,tempHigh_AlphaCut);           %�Q�Τw�g����Ƹ�Rule1~Rule9������AlphaCut 

Rule1_powerAns   =  Power_Ans(Rule1_AlphaCut,powerHigh);
Rule2_powerAns   =  Power_Ans(Rule2_AlphaCut,powerHigh);
Rule3_powerAns   =  Power_Ans(Rule3_AlphaCut,powerHigh);
Rule4_powerAns   =  Power_Ans(Rule4_AlphaCut,powerMedium);
Rule5_powerAns   =  Power_Ans(Rule5_AlphaCut,powerMedium);
Rule6_powerAns   =  Power_Ans(Rule6_AlphaCut,powerMedium);
Rule7_powerAns   =  Power_Ans(Rule7_AlphaCut,powerLow);
Rule8_powerAns   =  Power_Ans(Rule8_AlphaCut,powerLow);
Rule9_powerAns   =  Power_Ans(Rule9_AlphaCut,powerLow);                              %�Q�Τw�g����ƨ�AlphaCut�PRule1~Rule9���\�v�ϧΰ����p�B��C

powerAns_figure = max(Rule1_powerAns,Rule2_powerAns);
powerAns_figure = max(powerAns_figure,Rule3_powerAns);
powerAns_figure = max(powerAns_figure,Rule4_powerAns);
powerAns_figure = max(powerAns_figure,Rule5_powerAns);
powerAns_figure = max(powerAns_figure,Rule6_powerAns);
powerAns_figure = max(powerAns_figure,Rule7_powerAns);
powerAns_figure = max(powerAns_figure,Rule8_powerAns);
powerAns_figure = max(powerAns_figure,Rule9_powerAns);                               %�Q�Τw�g����ƨ�Rule1~Rule9�������Ҧ��\�v��X�ϧΰ����j�B��C

ss = 1;                                                                              %ss��X�b�@81���I��Y�b�@21���I�ұo�X��1701�ӥi�त�A�C���I�ѤW�z�B��ұo�X���ϧ�
for i=1:21                                                   
     for j=1:81                                             
         numerator = 0;                                              
         denominator = 0;                                   
         s = 599;
         for k=1:601                                                     
             s = s + 1;                                     
             numerator = numerator + s*powerAns_figure(ss,k);   
             denominator = denominator + powerAns_figure(ss,k);                      %COG�Ѽҽk
         end
         ss = ss+1;
         COG_poweranswer(i,j) = numerator / denominator;                
     end
end

Rule1_op_timeAns =  OperationTime_Ans(Rule1_AlphaCut,op_timeLong);
Rule2_op_timeAns =  OperationTime_Ans(Rule2_AlphaCut,op_timeMedium);
Rule3_op_timeAns =  OperationTime_Ans(Rule3_AlphaCut,op_timeShort);
Rule4_op_timeAns =  OperationTime_Ans(Rule4_AlphaCut,op_timeLong);
Rule5_op_timeAns =  OperationTime_Ans(Rule5_AlphaCut,op_timeMedium);
Rule6_op_timeAns =  OperationTime_Ans(Rule6_AlphaCut,op_timeShort);
Rule7_op_timeAns =  OperationTime_Ans(Rule7_AlphaCut,op_timeLong);
Rule8_op_timeAns =  OperationTime_Ans(Rule8_AlphaCut,op_timeMedium);
Rule9_op_timeAns =  OperationTime_Ans(Rule9_AlphaCut,op_timeShort);                  %�Q�Τw�g����ƨ�AlphaCut�PRule1~Rule9���B��ɶ��ϧΰ����p�B��C

op_timeAns_figure = max(Rule1_op_timeAns,Rule2_op_timeAns);
op_timeAns_figure = max(op_timeAns_figure,Rule3_op_timeAns);
op_timeAns_figure = max(op_timeAns_figure,Rule4_op_timeAns);
op_timeAns_figure = max(op_timeAns_figure,Rule5_op_timeAns);
op_timeAns_figure = max(op_timeAns_figure,Rule6_op_timeAns);
op_timeAns_figure = max(op_timeAns_figure,Rule7_op_timeAns);
op_timeAns_figure = max(op_timeAns_figure,Rule8_op_timeAns);
op_timeAns_figure = max(op_timeAns_figure,Rule9_op_timeAns);                         %�Q�Τw�g����ƨ�Rule1~Rule9�������Ҧ��B��ɶ���X�ϧΰ����j�B��C

ss = 1;
for i=1:21                                                   
     for j=1:81                                             
         numerator = 0;                                              
         denominator = 0;                                   
         for k=1:11                                                     
             s = s + 1;                                     
             numerator = numerator + (k-1)*op_timeAns_figure(ss,k);   
             denominator = denominator + op_timeAns_figure(ss,k);                   %COG�Ѽҽk
         end
         ss = ss+1;
         COG_op_timeanswer(i,j) = numerator / denominator;                
     end
end

%------------------------------------------------------------------------------------------------------------------------------------------------------%
x=-4:0.1:4; y=0:0.1:2; [X,Y]=meshgrid(x,y);     %�]�wX�BY�b

subplot(1,2,1); surf(X,Y,COG_poweranswer);    colorbar;   title("Microwave Oven Simalation (Fuzzy Theory)"); xlabel('X:Temperature(�XC)'); ylabel('Y:Weight(kg)'); zlabel('Power(w)');
subplot(1,2,2); surf(X,Y,COG_op_timeanswer);   colorbar;   title("Microwave Oven Simalation (Fuzzy Theory)"); xlabel('X:Temperature(�XC)'); ylabel('Y:Weight(kg)'); zlabel('Operation Time(min)');