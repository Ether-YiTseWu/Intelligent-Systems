function out = wheel_percent(fitnessValue)

for i=1:10
    if i == 1
        out(i) = fitnessValue(i)/sum(fitnessValue);                               %�ھڪ�l�@�N��X���A���ȡA�D�X�U�ƭȪ���v(binary code)  
    else            
        out(i) = fitnessValue(i)/sum(fitnessValue)+out(i-1);
    end
end                           

end