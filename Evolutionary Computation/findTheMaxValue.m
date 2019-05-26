clear;clc;

% x = [-10:0.01:10];    fx = -15*power(sin(2*x),2)-power((x-2),2)+160;
% plot(x,fx);                                                                                                                 %�Q��plot�j�P�e�X���D�ؤ��ϧ�                  
%-----------------------------------------------------------------------------------------------------------------------------------------------------%
internal = 20/1023;     x = -10:internal:10;                                                                                %�D�سW�w��10bits

B_initialGeneration_decimal = randi(1023,1,10);                                                                             %���X��l�@�N(�Q�i��)    B��binary code
B_initialGeneration_decode = x(B_initialGeneration_decimal);                                                                %���X��l�@�N(�ѽX��)    B��binary code
B_initialGeneration_binary = dec2bin(B_initialGeneration_decimal);                                                          %���X��l�@�N(�G�i��)    B��binary code
B_fitnessValue = power( (-15*power(sin(2*B_initialGeneration_decode),2)-power((B_initialGeneration_decode-2),2)+160) ,2);   %��X�A����

for i=1:10
    REA_initialGeneration_decode(i) = -10+(10-(-10))*rand(1,1);                                                                 %���X��l�@�N(�ѽX��)    REA����ƩM�t�ƭp��k
end
REA_fitnessValue = power( (-15*power(sin(2*REA_initialGeneration_decode),2)-power((REA_initialGeneration_decode-2),2)+160) ,2); %��X�A����             REA����ƩM�t�ƭp��k
%-----------------------------------------------------------------------------------------------------------------------------------------------------%
B_percentage = wheel_percent(B_fitnessValue);           %�Q�Φۤw�g��function���L�k��o�쪺��v(B)
REA_percentage = wheel_percent(REA_fitnessValue);       %�Q�Φۤw�g��function���L�k��o�쪺��v(REA)

B_wheelGeneration_decimal = rouletteWheelSelection(B_initialGeneration_decimal,B_percentage);          %�Q�Φۤw�g��function�ѥX�g�L���L�k��o�쪺��(�Q�i��)(B)
B_tournamentGeneration_decimal = tournamentSelection(B_initialGeneration_decimal,2);                   %�Q�Φۤw�g��function�ѥX�g�L�v���k��o�쪺��(�Q�i��)(B)

REA_wheelGeneration_decode = rouletteWheelSelection(REA_initialGeneration_decode,REA_percentage);      %�Q�Φۤw�g��function�ѥX�g�L�v���k��o�쪺��(REA)
REA_tournamentGeneration_decode = tournamentSelection(REA_initialGeneration_decode,2);                 %�Q�Φۤw�g��function�ѥX�g�L�v���k��o�쪺��(REA)
%-----------------------------------------------------------------------------------------------------------------------------------------------------%
b = randperm(10);                                                          %�M�w��t�ü�

B_wheel_parent = B_wheelGeneration_decimal(b(1:8));                        %�M�w�G�i�쫬�n��t���H�f(���L�k)
B_tournament_parent = B_tournamentGeneration_decimal(b(1:8));              %�M�w�G�i�쫬�n��t���H�f(�v���k)
REA_wheel_parent = REA_wheelGeneration_decode(b(1:8));                     %�M�wREA�n��t���H�f(���L�k)
REA_tournament_parent = REA_tournamentGeneration_decode(b(1:8));           %�M�wREA�n��t���H�f(�v���k)

REA_wheel_notparent = REA_wheelGeneration_decode(b(9:10));                 %����REA�S����t���H�f(���L�k)
REA_tournament_notparent = REA_tournamentGeneration_decode(b(9:10));       %����REA�S����t���H�f(�v���k)

%%%%%%%%%%%%%%%%%------�O�o�gbinary����t�k-------%%%%%%%%%%%%%%%%%%%%%%

R_wheel_generation = realValue_crossover(REA_wheel_parent);                %�Q�Φۤw�g��function������ƫ���t(���L�k)
R_tournament_generation = realValue_crossover(REA_tournament_parent);      %�Q�Φۤw�g��function������ƫ���t(�v���k)
EA_wheel_generation = evoAlgorithm_crossover(REA_wheel_parent);            %�Q�Φۤw�g��function����EA����t(���L�k)
EA_tournament_generation = evoAlgorithm_crossover(REA_tournament_parent);  %�Q�Φۤw�g��function����EA����t(�v���k)

R_wheel_generation(9:10) = REA_wheel_notparent;
R_tournament_generation(9:10) = REA_tournament_notparent;
EA_wheel_generation(9:10) = REA_wheel_notparent;
EA_tournament_generation(9:10) = REA_tournament_notparent;                 %�N�S����t�����s�[�Jpopulation���A46~49�欰�g�L��t�᪺�@�N��
%-----------------------------------------------------------------------------------------------------------------------------------------------------%
n = 1;
while n<501
    for i=1:10
        R_wheelFit(i) = power( (-15*power(sin(2*R_wheel_generation(i)),2)-power((R_wheel_generation(i)-2),2)+160) ,2);     %�D�X�A����(���L�k�A��ƫ�)
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
%         NEW_R_wheel_generation = NEW_R_wheel_generation + randN;                                    %�[�Jmutation��A�ܱo�ǩǪ�              
%     end
    
    R_wheel_generation = NEW_R_wheel_generation;
    
    n = n + 1;
end

ANS_R_wheel = power (R_wheel_plot(500),0.5);
xx = 1:n-1; 
plot(xx,R_wheel_plot); title(ANS_R_wheel);